local nvim_local_dir = vim.fn.expand("~/.local/share/nvim")
local lombok_jar = nvim_local_dir .. "/mason/packages/jdtls/lombok.jar"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = nvim_local_dir .. "/jdtls-workspaces/" .. project_name
local lsp_utils = require("lsp_utils")

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
    "-javaagent:" .. lombok_jar,
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
  handlers = {
    ["language/status"] = function() end,
  },
  capabilities = lsp_utils.get_capabilities(),
  on_attach = lsp_utils.on_attach,
})

function RunJava()
  local function show_output(output)
    vim.cmd("split")
    vim.cmd("enew")
    vim.fn.append(0, output)
    --vim.cmd("1d") -- Remove the empty first line
    vim.bo[0].modifiable = false
  end

  local filename = vim.fn.expand("%") -- Get the current file name
  local class_name = vim.fn.fnamemodify(filename, ":r") -- Extract the class name
  local compile_cmd = "javac " .. filename
  local run_cmd = "java " .. class_name

  -- Create a temporary file to capture the compile output
  local temp_file = vim.fn.tempname()

  -- Run the compilation command and save the output to the temporary file
  local compile_exit_code = vim.fn.system(compile_cmd .. " > " .. temp_file .. " 2>&1")

  -- Check the exit code of the compile command
  if compile_exit_code == 0 then
    -- Compilation was successful, run the Java program
    show_output(vim.fn.systemlist(run_cmd))
  else
    -- Compilation failed, display the error output from the temporary file
    show_output(vim.fn.readfile(temp_file))
  end

  -- Clean up the temporary file and class file
  vim.fn.delete(temp_file)
  vim.fn.delete(vim.fn.expand("%:p:h") .. "/" .. class_name .. ".class")
end

-- Define a VimScript command to execute the Lua function
vim.api.nvim_exec(
  [[
  command! RunJava lua RunJava()
]],
  false
)
