local dap = require('dap')

dap.adapters.node = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/adapters/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  host = '127.0.0.1',
  executable = {
    command = '/Users/morganmccauley/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
    args = {
      '--liblldb',
      '/Users/morganmccauley/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib',
      '--port',
      '${port}'
    },
  },
}

-- TODO dont open term
-- TODO list cargo binaries https://github.com/vadimcn/vscode-lldb/blob/master/MANUAL.md#cargo-support
dap.configurations.rust = {
  {
    name = 'codelldb',
    type = 'codelldb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    terminal = 'console',
    args = function()
      local arguments = {}

      for arg in vim.fn.input('Arguments: '):gmatch('%S+') do
        table.insert(arguments, arg)
      end

      return arguments
    end,
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

dap.configurations.javascript = {
  {
    name = 'node',
    type = 'node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to node process',
    type = 'node',
    request = 'attach',
    processId = require 'dap.utils'.pick_process,
  },
}

local keymap_restore = {}

dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == 'K' then
        table.insert(keymap_restore, keymap)
        vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end

  vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
  dap.repl.close()

  vim.api.nvim_del_keymap('n', 'K')

  for _, keymap in pairs(keymap_restore) do
    vim.keymap.set(
      keymap.mode,
      keymap.lhs,
      keymap.rhs or keymap.callback,
      {
        silent = keymap.silent == 1,
        buffer = keymap.buffer,
      }
    )
  end
  keymap_restore = {}
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'dap-float' },
  callback = function(t)
    vim.api.nvim_buf_set_keymap(t.buf, 'n', 'q', ':q<Cr>', { silent = true })
    vim.api.nvim_buf_set_keymap(t.buf, 'n', '<Esc>', ':q<Cr>', { silent = true })
  end
})

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition',
  { text = '', texthl = 'DiagnosticSignWarning', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'white', linehl = '', numhl = '' })
