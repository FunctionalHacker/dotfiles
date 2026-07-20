local mason_pkg = vim.fn.stdpath("data") .. "/mason/packages"

-- Debug adapter for NeoVim
--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      opts = {},
    },
  },
  init = function()
    local dap = require("dap")
    local configurations = dap.configurations
    local adapters = dap.adapters

    -- Applies all given configurations to the given filetypes
    --- @param filetypes string[]
    --- @param configs dap.Configuration[]
    local function dapConfigure(filetypes, configs)
      for _, ft in ipairs(filetypes) do
        configurations[ft] = configs
      end
    end

    -- Bash/sh
    local bash_pkg = mason_pkg .. "/bash-debug-adapter"
    adapters.bashdb = {
      type = "executable",
      command = bash_pkg .. "/bash-debug-adapter",
      name = "bashdb",
    }
    configurations.sh = {
      name = "Debug with bashdb",
      type = "bashdb",
      request = "launch",
      showDebugOutput = true,
      trace = true,
      pathBashdbLib = bash_pkg .. "/extension/bashdb_dir",
      pathBashdb = bash_pkg .. "/extension/bashdb_dir/bashdb",
      file = "${file}",
      program = "${file}",
      cwd = "${workspaceFolder}",
      pathCat = "cat",
      pathBash = "/bin/bash",
      pathMkfifo = "mkfifo",
      pathPkill = "pkill",
      args = {},
      env = {},
      terminalKind = "integrated",
    }

    -- JavaScript/TypeScript in Firefox
    adapters.firefox = {
      type = "executable",
      command = "node",
      args = { mason_pkg .. "/firefox-debug-adapter/dist/adapter.bundle.js" },
    }

    --- @type dap.Configuration[]
    local browserConfigs = {
      {
        name = "Firefox attach",
        type = "firefox",
        request = "attach",
        url = "http://localhost:5173",
        webRoot = "${workspaceFolder}",
      },
    }

    dapConfigure(
      { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      {
        {
          name = "QCC Firefox launch",
          type = "firefox",
          request = "launch",
          url = "http://localhost:5173/react/dashboard/",
          webRoot = "${workspaceFolder}/views/portal/react",
        },
      }
    )
  end,
}
