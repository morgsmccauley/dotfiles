require 'toggleterm'.setup {
  shade_terminals = false,
  direction = 'vertical',
  open_mapping = [[<C-t>]],
  start_in_insert = true,
  persist_size = false,
  on_open = function(t)
    vim.wo.winfixwidth = false

    -- hack
    vim.api.nvim_command [[wincmd =]]

    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-q>', [[<C-\><C-n>:q!<Cr>]], { noremap = true })
  end,
}
