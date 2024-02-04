-- Display possible keybinds
-- Here I have also defined some generic keybinds
-- Plugin specific keybinds are set up in plugin configuration file

local function toggle_theme()
  local current_theme = vim.fn.eval("&background")
  if current_theme == "dark" then
    vim.cmd("set background=light")
  else
    vim.cmd("set background=dark")
  end
end

--- @type LazyPluginSpec
return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.setup()

    wk.register({
      h = { "<cmd>nohlsearch<cr>", "Turn off search highlight" },
      b = { toggle_theme, "Toggle background between dark and light" },
    }, { prefix = "<leader>" })

    wk.register({
      ["<Tab>"] = { "<cmd>bnext<cr>", "Next buffer" },
      ["<S-Tab>"] = { "<cmd>bprevious<cr>", "Previous buffer" },
    })

    -- Exit terminal insert mode with esc
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})
  end,
}
