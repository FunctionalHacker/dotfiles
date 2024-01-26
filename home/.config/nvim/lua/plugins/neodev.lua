-- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
return {
  "folke/neodev.nvim",
  --- @type LuaDevOptions
  opts = {
    override = function(root_dir, library)
      local dotfiles_path = tostring(vim.fn.expand("~/git/dotfiles"))
      if string.find(root_dir, dotfiles_path, 1, true) then
        library.enabled = true
        library.plugins = true
      end
    end,
  },
}
