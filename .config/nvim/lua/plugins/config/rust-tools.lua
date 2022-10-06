local rt = require('rust-tools')
local utils = require('rust-tools.utils.utils')
local dap = require('rust-tools.dap')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

rt.setup({
	tools = {
		executor = {
			execute_command = function(command, args, cwd)
				local cmd = utils.make_command_from_args(command, args)
				vim.api.nvim_command('TermExec cmd=\'' .. cmd .. '\'' .. 'dir=\'' .. cwd .. '\'')
			end
		}
	},
	hover_actions = {
		auto_focus = true,
	},
	server = {
		capabilities = capabilities,
		on_attach = function(_, bufnr)
			vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr })

			vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
				buffer = bufnr,
				callback = function() vim.lsp.buf.format({ async = false }) end,
			})
		end
	},
	dap = {
		adapter = dap.get_codelldb_adapter(
			'/Users/morganmccauley/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
			'/Users/morganmccauley/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib'
		)
	}
})
