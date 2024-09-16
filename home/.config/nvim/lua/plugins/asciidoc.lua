-- AsciiDoc plugins are grouped together here
return {
  -- Vim ♥️ Asciidoctor
  --- @type LazyPluginSpec
  {
    "habamax/vim-asciidoctor",
    ft = { "asciidoctor", "asciidoc" },
  },
  -- AsciiDoc preview
  --- @type LazyPluginSpec
  {
    "tigion/nvim-asciidoc-preview",
    ft = { "asciidoctor", "asciidoc" },
  },
}
