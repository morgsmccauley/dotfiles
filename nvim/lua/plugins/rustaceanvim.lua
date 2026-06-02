local rust_analyzer_disabled_roots = {
  vim.fs.normalize(vim.fn.expand('~/Developer/jito-solana-private')),
}

local function path_is_under(path, root)
  return path == root or vim.startswith(path, root .. '/')
end

local function rust_analyzer_is_disabled(path)
  local normalized = vim.fs.normalize(path)
  for _, root in ipairs(rust_analyzer_disabled_roots) do
    if path_is_under(normalized, root) then
      return true
    end
  end

  return false
end

vim.g.rustaceanvim = {
  tools = {
    float_win_config = {
      border = 'rounded',
    },
  },
  server = {
    auto_attach = function(bufnr)
      if #vim.bo[bufnr].buftype > 0 then
        return false
      end

      local path = vim.api.nvim_buf_get_name(bufnr)
      if path == '' then
        return false
      end

      return not rust_analyzer_is_disabled(path)
    end,
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
        references = {
          excludeTests = true
        },
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
          extraEnv = {
            RUSTFLAGS = '--cfg tokio_unstable',
            SKIP_CAPNP_COMPAT_CHECK = '1',
          },
          buildScripts = {
            enable = true,
            useRustcWrapper = false,
          },
          targetDir = true,
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
