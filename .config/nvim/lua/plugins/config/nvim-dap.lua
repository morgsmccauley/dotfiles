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
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  }
}

dap.configurations.javascript = {
  {
    name = 'Launch node',
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

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DiagnosticSignWarning', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '⮕', texthl = 'white', linehl = '', numhl = '' })
