local util = require("lspconfig.util")

-- Add rootdir for non-npm projects for ts_ls
return {
  root_dir = function(bufnr, on_dir)
    local project_root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', '.ts_ls_enable' }
    local project_root = vim.fs.root(bufnr, project_root_markers)
    if not project_root then
      return
    end

    on_dir(project_root)
  end,
}
