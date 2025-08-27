-- Make editing passwords safer
--- @type LazyPluginSpec
return {
  "https://git.zx2c4.com/password-store",
  event = "VeryLazy",
  init = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "contrib/vim/redact_pass.vim")
  end,
}
