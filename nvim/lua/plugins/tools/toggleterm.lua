return {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  config = function()
    require 'toggleterm'.setup {
      shade_terminals = false,
      direction = 'vertical',
      open_mapping = [[<C-t>]],
      start_in_insert = true,
      persist_size = false,
      on_open = function(t)
        -- vim.pretty_print(t)

        vim.o.bufhidden = 'hide'
        vim.wo.winfixwidth = false

        -- hack
        vim.api.nvim_command [[wincmd =]]

        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true })

        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })
        -- vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-l>', [[<C-\><C-n><C-W><C-l>]], { noremap = true })

        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-q>', [[<C-\><C-n><Cmd>q!<Cr>]], { noremap = true })
        -- vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-t>', [[<C-\><C-n><Cmd>hide<Cr>]], { noremap = true })

        -- perform relevant action rather than sending keycodes
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<S-space>', ' ', { noremap = true })
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<S-BS>', '<C-_>', { noremap = true })
      end,
    }
  end
}
