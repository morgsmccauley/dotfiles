local Job = require('plenary.job')

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        require('dap-vscode-js').setup({
          adapters = { 'pwa-node' },
          debugger_path = os.getenv('HOME') .. '/.local/share/nvim/lazy/vscode-js-debug'
        })
      end
    },
    -- {
    --   'microsoft/vscode-js-debug',
    --   build =
    --   'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && rm -rf out && mv dist out && git checkout package-lock.json',
    -- },
  },
  config = function()
    require('dapui').setup()

    local dap = require('dap')

    dap.adapters.lldb = {
      type = 'executable',
      command = 'lldb-dap',
      name = 'lldb',
    }

    -- TODO dont open term
    -- TODO list cargo binaries https://github.com/vadimcn/vscode-lldb/blob/master/MANUAL.md#cargo-support
    dap.configurations.rust = {
      {
        name = 'launch',
        type = 'lldb',
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
          local executables = Job:new({
            command = 'find',
            args = {
              'target',
              '-maxdepth', '2',
              '-type', 'f',
              '-perm', '+111'
            },
          }):sync()
          return require('dap.ui').pick_one(executables, 'Executables', function(ex) return ex end)
        end,
      },
    }

    dap.configurations.javascript = {
      {
        name = 'Current file',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        name = 'Attach to node process',
        type = 'pwa-node',
        request = 'attach',
        processId = require 'dap.utils'.pick_process,
        cwd = '${workspaceFolder}',
      },
      {
        name = 'Debug NPM tests',
        type = 'pwa-node',
        request = 'launch',
        runtimeExecutable = 'npm',
        runtimeArgs = {
          'test',
        },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      }
    }

    dap.configurations.typescript = dap.configurations.javascript

    dap.listeners.after['event_initialized']['me'] = function()
      -- require('dapui').toggle()
    end

    dap.listeners.after['event_terminated']['me'] = function()
      -- require('dapui').toggle()
      -- dap.repl.close()
    end

    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = { 'dap-float' },
      callback = function(t)
        vim.api.nvim_buf_set_keymap(t.buf, 'n', 'q', ':q<Cr>', { silent = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'n', '<Esc>', ':q<Cr>', { silent = true })
      end
    })

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition',
      { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'white', linehl = '', numhl = '' })
  end
}
