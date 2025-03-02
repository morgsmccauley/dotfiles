vim.g.rustaceanvim = {
  tools = {
    float_win_config = {
      border = 'rounded',
    },
    -- executor_alias = 'termopen'
    env = {
      PROTOC = "/usr/local/bin/protoc"
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

      local augroup = vim.api.nvim_create_augroup('RustLspFormatting_' .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        group = augroup,
        buffer = bufnr,
        callback = function() vim.lsp.buf.format() end,
      })
    end,
    default_settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy',
          extraArgs = { '--no-deps' }
        },
        cargo = {
          buildScripts = {
            enable = true
          }
        }
      },
    },
  },
  dap = {},
}
return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  lazy = false,
}
