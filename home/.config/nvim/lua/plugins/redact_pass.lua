-- Make editing passwords safer
return {
  "https://git.zx2c4.com/password-store",
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "contrib/vim/redact_pass.vim")
  end,
}
