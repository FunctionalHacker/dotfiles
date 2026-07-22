-- Git blame in virtual text
--- @type LazyPluginSpec
return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  --- @module "gitblame"
  --- @type SetupOptions
  opts = {
    enabled = true,
    message_template = "<author> • <date> • <summary>",
    date_format = "%Y-%m-%d",
    highlight_group = 'GitBlameVirtualText'
  },
}
