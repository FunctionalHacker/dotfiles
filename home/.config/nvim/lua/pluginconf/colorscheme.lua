require("catppuccin").setup({
    transparent_background = false,
    term_colors = false,
    compile = {enabled = true, path = vim.fn.stdpath "cache" .. "/catppuccin"},
    styles = {
        comments = {"italic"},
        functions = {"italic"},
        keywords = {"italic"},
        strings = {},
        variables = {}
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = {"italic"},
                hints = {"italic"},
                warnings = {"italic"},
                information = {"italic"}
            },
            underlines = {
                errors = {"underline"},
                hints = {"underline"},
                warnings = {"underline"},
                information = {"underline"}
            }
        },
        lsp_trouble = false,
        lsp_saga = false,
        gitgutter = true,
        gitsigns = false,
        telescope = true,
        nvimtree = {enabled = false, show_root = false},
        which_key = false,
        indent_blankline = {enabled = true, colored_indent_levels = false},
        dashboard = false,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        bufferline = false,
        markdown = false,
        lightspeed = false,
        ts_rainbow = false,
        hop = false
    }
})
vim.cmd [[colorscheme catppuccin]]
