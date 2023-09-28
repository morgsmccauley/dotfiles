return {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
  config = function()
    local rt = require('rust-tools')
    local utils = require('rust-tools.utils.utils')
    local dap = require('rust-tools.dap')
    local cmp_lsp = require('cmp_nvim_lsp')

    local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Disable showing full completion item in completion menu
    -- note: setting to false via overrides doesn't seem to work
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = nil

    rt.setup({
      tools = {
        executor = {
          execute_command = function(command, args, cwd)
            local cmd = utils.make_command_from_args(command, args)
            vim.api.nvim_command('TermExec cmd=\'' .. cmd .. '\'' .. 'dir=\'' .. cwd .. '\'')
          end
        },
        inlay_hints = {
          auto = false
        },
      },
      server = {
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
              extraArgs = { '--no-deps' }
            }
          }
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = false

          require('which-key').register({
            ['<leader>ch'] = { rt.hover_actions.hover_actions, 'hover', buffer = bufnr }
          });

          vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ async = false }) end,
          })
        end
      },
      dap = {
        adapter = dap.get_codelldb_adapter(
          vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
          vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib'
        )
      }
    })
  end
}
