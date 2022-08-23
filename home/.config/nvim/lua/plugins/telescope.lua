return function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    telescope.setup {
        pickers = {find_files = {find_command = {"fd", "-Ht", "f"}}}
    }

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')

    -- Keybinds
    vim.keymap.set('n', '<C-t>', vim.cmd.Telescope)
    vim.keymap.set('n', '<C-f>', builtin.find_files)
    vim.keymap.set('n', '<C-g>', builtin.live_grep)
end
