--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["D"] = "duplicate_file",
              },
            },
          },
          actions = {
            duplicate_file = {
              action = function(_, item)
                if not item then
                  return
                end

                local new_name = vim.fn.input("Duplicate as: ", item.file)
                if new_name == "" or vim.fn.filereadable(new_name) == 1 then
                  vim.notify("Invalid name or file exists", vim.log.levels.WARN)
                  return
                end
                vim.uv.fs_copyfile(item.file, new_name)
                vim.notify("Duplicated to " .. new_name)
              end,
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Open/close file explorer",
    },
  },
}
