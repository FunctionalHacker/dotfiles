local g = vim.g

-- Change scale factor with C= and C-
g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  g.neovide_scale_factor = g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.25)
end)

-- Hide mouse when typing in neovide
g.neovide_hide_mouse_when_typing = true

-- Enable cursor particles in neovide
g.neovide_cursor_vfx_mode = "railgun"