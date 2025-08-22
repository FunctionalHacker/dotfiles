local forgejo_patterns = {
  branch = "/src/branch/{branch}",
  file = "/src/branch/{branch}/{file}#L{line_start}-L{line_end}",
  permalink = "/src/commit/{commit}/{file}#L{line_start}-L{line_end}",
  commit = "/commit/{commit}",
}

--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    gitbrowse = {
      what = "permalink",
      url_patterns = {
        ["git.korhonen.cc"] = forgejo_patterns,
        ["git.tolkku.net"] = forgejo_patterns,
        ["codeberg.org"] = forgejo_patterns,
        ["code.forgejo.org"] = forgejo_patterns,
        ["github%.com"] = {
          branch = "/tree/{branch}",
          file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
          permalink = "/blob/{commit}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
        },
        ["gitlab%.com"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
          permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
          commit = "/-/commit/{commit}",
        },
      },
    },
  },
  keys = {
    {
      "<leader>go",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Open in browser",
    },
  },
}
