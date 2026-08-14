local filetypes = {
  { text = "javascript" },
  { text = "lua" },
  { text = "python" },
  { text = "asciidoctor" },
  { text = "markdown" },
}

local function pick_scratch_filetype()
  Snacks.picker.pick({
    items = filetypes,
    format = "text",
    layout = {
      preset = "vscode",
      layout = { title = " Select a filetype: " },
    },
    actions = {
      confirm = function(picker, item)
        picker:close()
        vim.schedule(function()
          local items = picker:items()
          if #items == 0 then
            Snacks.scratch()
          else
            Snacks.scratch({ ft = item.text })
          end
        end)
      end,
    },
  })
end

local function run_scratch_file(cmd_args, title)
  return function(self)
    -- Save the buffer so the external command sees the latest changes
    vim.api.nvim_buf_call(self.buf, function()
      vim.cmd("silent! write")
    end)

    -- Grab the actual file path of the scratch buffer
    local file = vim.api.nvim_buf_get_name(self.buf)

    -- Build the command
    local cmd = vim.deepcopy(cmd_args)
    table.insert(cmd, file)

    -- Execute asynchronously
    vim.system(cmd, { text = true }, function(out)
      vim.schedule(function()
        local output = {}
        if out.stdout and out.stdout ~= "" then
          table.insert(output, out.stdout)
        end
        if out.stderr and out.stderr ~= "" then
          table.insert(output, out.stderr)
        end
        if out.code ~= 0 and out.stderr == "" and out.stdout == "" then
          table.insert(output, "Command failed with exit code " .. out.code)
        end
        local res = #output > 0 and table.concat(output, "\n") or "No output"
        Snacks.win({
          title = title .. "output",
          text = res,
          ft = "text",
        })
      end)
    end)
  end
end

--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    scratch = {
      win_by_ft = {
        lua = {
          keys = {
            ["source"] = {
              "<cr>",
              run_scratch_file({ "lua" }, "Lua"),
              desc = "Run Lua file",
              mode = { "n", "x" },
            },
          },
        },
        javascript = {
          keys = {
            ["source"] = {
              "<cr>",
              run_scratch_file({ "node" }, "JavaScript"),
              desc = "Run JavaScript file",
              mode = { "n", "x" },
            },
          },
        },
        python = {
          keys = {
            ["source"] = {
              "<cr>",
              run_scratch_file({ "python" }, "Python"),
              desc = "Run Python file",
              mode = { "n", "x" },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>.",
      function()
        pick_scratch_filetype()
      end,
      desc = "Open new scratch buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select scratch buffer",
    },
  },
}
