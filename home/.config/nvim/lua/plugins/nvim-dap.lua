-- Debug adapter for NeoVim

local masonPkg = vim.fn.stdpath("data") .. "/mason/packages"
--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = true,
    },
  },
  config = function()
    local dap = require("dap")
    local configurations = dap.configurations
    local adapters = dap.adapters
    local pick_process = require("dap.utils").pick_process

    -- Applies all given configurations to the given filetypes
    --- @param filetypes string[]
    --- @param configs dap.Configuration[]
    local function dapConfigure(filetypes, configs)
      for _, ft in ipairs(filetypes) do
        configurations[ft] = configs
      end
    end

    -- Bash/sh
    local bashAdapter = masonPkg .. "/bash-debug-adapter"
    local bashExtension = bashAdapter .. "/extension"
    adapters.bashdb = {
      type = "executable",
      command = bashAdapter .. "/bash-debug-adapter",
      name = "bashdb",
    }
    configurations.sh = {
      name = "Debug with bashdb",
      type = "bashdb",
      request = "launch",
      showDebugOutput = true,
      trace = true,
      pathBashdbLib = bashExtension .. "/bashdb_dir",
      pathBashdb = bashExtension .. "/bashdb_dir/bashdb",
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

    -- JavaScript/TypeScript in Firefox/Chrome/Node
    adapters.libreWolf = {
      type = "executable",
      command = "node",
      args = { masonPkg .. "/firefox-debug-adapter/dist/adapter.bundle.js" },
    }
    adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { masonPkg .. "/js-debug-adapter/js-debug/src/dapDebugServer.js", "8123" },
      },
    }

    --- @type dap.Configuration[]
    local browserConfigs = {
      {
        name = "LibreWolf attach",
        type = "libreWolf",
        request = "attach",
        url = "http://localhost:4000",
        webRoot = "${workspaceFolder}",
      },
      {
        name = "Chrome attach",
        type = "pwa-chrome",
        request = "attach",
        cwd = "${workspaceFolder}",
      },
    }

    --- @type dap.Configuration[]
    local nodeConfigs = {
      {
        name = "Node attach",
        type = "pwa-node",
        request = "attach",
        processId = pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        name = "Node launch",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        port = "8123",
      },
    }

    dapConfigure({ "typescriptreact", "javascriptreact" }, browserConfigs)
    dapConfigure({ "typescript", "javascript" }, vim.tbl_extend("force", browserConfigs, nodeConfigs))

    -- Java
    configurations.java = {
      {
        name = "Debug (Attach) - Remote",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = 9009,
      },
    }
  end,
}
