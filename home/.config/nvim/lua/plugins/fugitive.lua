local k = vim.keymap.set

-- Git commands
--- @type LazyPluginSpec
return {
  "tpope/vim-fugitive",
  dependencies = { "borissov/fugitive-gitea" },
  config = function()
    vim.g.fugitive_gitea_domains = {
      "https://git.korhonen.cc",
      "https://git.rossum.fi",
    }

    -- Keybinds
    k("n", "<leader>gs", function()
      vim.cmd("Git status")
    end, { desc = "Status" })

    k("n", "<leader>gaa", function()
      vim.cmd("Git add -A")
    end, { desc = "All" })

    k("n", "<leader>gc", function()
      vim.cmd("Git commit")
    end, { desc = "Commit" })

    k("n", "<leader>gu", function()
      vim.cmd("Git push")
    end, { desc = "Push" })

    k("n", "<leader>gd", function()
      vim.cmd("Git pull")
    end, { desc = "Pull" })

    k({ "n", "x" }, "<leader>gb", "<cmd>'<,'>GBrowse<cr><esc>", { desc = "Open in browser" })
  end,
}
