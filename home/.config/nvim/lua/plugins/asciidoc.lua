local asciidoc_fts = { "asciidoctor", "asciidoc" }

-- AsciiDoc plugins are grouped together here
return {
  -- Vim ♥️ Asciidoctor
  --- @type LazyPluginSpec
  {
    "habamax/vim-asciidoctor",
    ft = asciidoc_fts,
  },
  -- AsciiDoc preview
  --- @type LazyPluginSpec
  {
    "tigion/nvim-asciidoc-preview",
    ft = asciidoc_fts,
  },
}
