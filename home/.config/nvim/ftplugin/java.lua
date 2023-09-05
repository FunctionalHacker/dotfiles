local nvim_local_dir = vim.fn.expand("~/.local/share/nvim")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = nvim_local_dir .. "/jdtls-workspaces/" .. project_name

require("jdtls").start_or_attach({
  cmd = {
    "/usr/lib/jvm/java-19-openjdk-amd64/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    nvim_local_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
    "-configuration",
    nvim_local_dir .. "/mason/packages/jdtls/config_linux",
    "-data",
    workspace_dir,
  },
  settings = { java = { signatureHelp = { enabled = true } } },
  completion = { favoriteStaticMembers = { "java.text.MessageFormat.format" } },
  runtimes = {
    {
      name = "JavaSE-1.8",
      path = "/usr/lib/jvm/java-8-openjdk-amd64/",
    },
    {
      name = "JavaSE-11",
      path = "/usr/lib/jvm/java-11-openjdk-amd64/",
    },
    {
      name = "JavaSE-19",
      path = "/usr/lib/jvm/java-19-openjdk-amd64/",
    },
  },
})

require("plugins.mason").map_keys()
