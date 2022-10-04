local dap = require('dap')

dap.adapters.node = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/adapters/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/adapters/vscode-firefox-debug/dist/adapter.bundle.js' },
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
  name = 'lldb',
}

dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
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
    name = 'Debug with Firefox',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    url = 'http://localhost:9999',
    webRoot = '${workspaceFolder}',
    firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox-bin'
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
