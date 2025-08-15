-- General keybinds

vim.keymap.set("n", "<leader>b", function()
  local current_theme = vim.fn.eval("&background")
  if current_theme == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background between dark and light" })

vim.keymap.set("n", "<leader>h", function()
  vim.cmd("nohlsearch")
end, { desc = "Turn off search highlight" })

vim.keymap.set("n", "<leader>a", function()
  vim.cmd("edit #")
end, { desc = "Edit alternate file" })

vim.keymap.set("n", "<Tab>", function()
  vim.cmd("bnext")
end, { desc = "Next buffer" })

vim.keymap.set("n", "<S-Tab>", function()
  vim.cmd("bprevious")
end, { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>co", function()
  vim.cmd('silent! execute "%bd|e#|bd#"')
end, { desc = "Close other buffers" })

-- LSP keybinds (more in telescope configuration)

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format with LSP" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Signature help" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add folder" })
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove folder" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Type definition" })

vim.keymap.set("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List folders" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
