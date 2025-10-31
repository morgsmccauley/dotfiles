vim.g.rustaceanvim = {
  tools = {
    float_win_config = {
      border = 'rounded',
    },
  },
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set('n', '<leader>ce', '<Cmd>RustLsp explainError<Cr>',
        { silent = true, buffer = bufnr, desc = 'Explain error (rust)' })
      vim.keymap.set('n', '<leader>cm', '<Cmd>RustLsp expandMacro<Cr>',
        { silent = true, buffer = bufnr, desc = 'Expand macro (rust)' })
      vim.keymap.set('n', '<leader>co', '<Cmd>RustLsp openDocs<Cr>',
        { silent = true, buffer = bufnr, desc = 'Open docs (rust)' })
      vim.keymap.set('n', '<leader>cc', '<Cmd>RustLsp openCargo<Cr>',
        { silent = true, buffer = bufnr, desc = 'Open docs (rust)' })
      vim.keymap.set('n', '<leader>cp', '<Cmd>RustLsp parentModule<Cr>',
        { silent = true, buffer = bufnr, desc = 'Open docs (rust)' })

      vim.keymap.set(
        "n",
        "K",
        function()
          vim.cmd.RustLsp({ 'hover', 'actions' })
        end,
        { silent = true, buffer = bufnr }
      )

      local augroup = vim.api.nvim_create_augroup('RustLspFormatting_' .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        group = augroup,
        buffer = bufnr,
        callback = function() vim.lsp.buf.format() end,
      })
    end,
    default_settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
          styleLints = {
            enable = true,
          }
        },
        procMacro = {
          enable = true,
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
          -- targetDir = true,
        },
        checkOnSave = true,
        check = {
          -- command = 'clippy',
          -- extraArgs = { '--no-deps' }

          command = 'check'
        },
        rustc = {
          source = 'discover',
        },
      },
    },
  },
  dap = {},
}
return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
}
