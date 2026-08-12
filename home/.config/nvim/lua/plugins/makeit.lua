--- @type LazyPluginSpec
return {
  "AtifChy/makeit.nvim",
  cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
  --- @module "makeit"
  --- @type MakeitConfig
  opts = {
    picker = "snacks",
  },
  dependencies = {
    {
      --- @module "overseer"
      --- @type overseer.SetupOpts
      "stevearc/overseer.nvim",
      commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
      cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
      opts = {
        task_list = {
          direction = "bottom",
          min_height = 25,
          max_height = 25,
          default_detail = 1,
        },
      },
    },
  },
}
