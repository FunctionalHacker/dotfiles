-- Startup dashboard
--- @type LazyPluginSpec
return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }
    dashboard.section.buttons.val = {
      dashboard.button(
        "<leader>p",
        "📽  Open a project",
        ":lua require('telescope').extensions.project.project()<CR>"
      ),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("<C-f>", "🔍  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("<C-g>", "𑪢  Grep files", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("l", "🛋  Lazy", ":Lazy<CR>"),
      dashboard.button("m", "📦  Mason", ":Mason<CR>"),
      dashboard.button("q", "ꭙ  Quit NeoVim", ":qa<CR>"),
    }

    -- Fortune in footer
    dashboard.section.footer.val = require("alpha.fortune")()

    dashboard.config.opts.noautocmd = true

    vim.cmd([[autocmd User AlphaReady echo 'ready']])

    alpha.setup(dashboard.config)
  end,
}
