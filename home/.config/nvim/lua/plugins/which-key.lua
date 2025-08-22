-- Display possible keybinds
--- @type LazyPluginSpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  --- @module "which-key"
  --- @type wk.Opts
  opts = {
    -- Global keybinds not relating to any plugin.
    -- See plugin configuration for plugin keybinds
    spec = {
      -- Group names
      { "g", group = "Go to" },
      { "<leader>", group = "Leader" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Misc" },
      { "<leader>w", group = "Workspace" },
      { "<leader>d", group = "Dismiss" },
      { "<leader>r", group = "Rename" },
      { "<leader>f", group = "Find" },
      { "<leader>s", group = "Search", mode = { "n", "x" } },
      { "<leader>g", group = "Git", mode = { "n", "v" } },
      { "<leader>gr", group = "Reset" },
      { "<leader>ga", group = "Add" },

      -- General keybinds
      {
        "<leader>t",
        function()
          local current_theme = vim.fn.eval("&background")
          if current_theme == "dark" then
            vim.o.background = "light"
          else
            vim.o.background = "dark"
          end
        end,
        desc = "Toggle background between dark and light",
      },
      {
        "<leader>o",
        function()
          local bufnr = 0
          local start_pos = vim.api.nvim_buf_get_mark(bufnr, "<")
          local end_pos = vim.api.nvim_buf_get_mark(bufnr, ">")

          local selection = table.concat(
            vim.api.nvim_buf_get_text(bufnr, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {}),
            "\n"
          )
          -- :gsub("^%s+", "")
          -- :gsub("%s+$", "")

          if selection ~= "" then
            vim.fn.jobstart({ "xdg-open", selection }, { detach = true })
          else
            vim.notify("No text selected to open", vim.log.levels.WARN)
          end
        end,
        mode = { "x" },
        desc = "Open selection with xdg-open",
      },
      {
        "<leader>dh",
        function()
          vim.cmd("nohlsearch")
        end,
        desc = "Search highlight",
      },
      {
        "<leader>a",
        function()
          vim.cmd("edit #")
        end,
        desc = "Edit alternate file",
      },
      {
        "<Tab>",
        function()
          vim.cmd("bnext")
        end,
        desc = "Next buffer",
      },
      {
        "<S-Tab>",
        function()
          vim.cmd("bprevious")
        end,
        desc = "Previous buffer",
      },
      {
        "<leader>bo",
        function()
          vim.cmd('silent! execute "%bd|e#|bd#"')
        end,
        desc = "Close [o]ther buffers",
      },

      -- LSP keybinds (more in snacks picker configuration)
      { "<leader>F", vim.lsp.buf.format, desc = "Format with LSP" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>k", vim.lsp.buf.signature_help, desc = "Signature help" },
      { "<leader>rs", vim.lsp.buf.rename, desc = "Symbol" },
      { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add folder" },
      { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove folder" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gD", vim.lsp.buf.declaration, desc = "Declaration" },
      {
        "<leader>wl",
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = "List folders",
      },
      {
        "[d",
        function()
          vim.diagnostic.jump({ count = -1, float = true })
        end,
        desc = "Previous diagnostic",
      },
      {
        "]d",
        function()
          vim.diagnostic.jump({ count = 1, float = true })
        end,
        desc = "Next diagnostic",
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
