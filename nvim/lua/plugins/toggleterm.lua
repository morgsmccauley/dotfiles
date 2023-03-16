return {
  'akinsho/toggleterm.nvim',
  keys = {
    {
      '<C-t>',
      '<Cmd>exe v:count1 . "ToggleTerm"<Cr>',
      { silent = true, noremap = true }
    }
  },
  cmd = { 'TermExec' },
  config = function()
    require 'toggleterm'.setup {
      persist_mode = false, -- always insert on enter
      shade_terminals = false,
      direction = 'vertical',
      open_mapping = [[<C-t>]],
      start_in_insert = true,
      persist_size = false,
      on_open = function(t)
        vim.o.bufhidden = 'hide'
        vim.wo.winfixwidth = false

        -- keep terminal equal size
        vim.api.nvim_command [[wincmd =]]

        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true })

        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })

        -- this looks for fzf in every process so will not do as expected if fzf is running in a different terminal
        vim.keymap.set(
          't',
          '<C-j>',
          function()
            local isFzf = vim.fn.system('ps -o state= -o comm= | grep -iE \'^[^TXZ ]+ +(\\S+\\/)?fzf$\'') ~= ''
            if isFzf then
              return [[<C-j>]]
            else
              return [[<C-\><C-n><C-w><C-j>]]
            end
          end,
          { buffer = t.bufnr, expr = true }
        )
        vim.keymap.set(
          't',
          '<C-k>',
          function()
            local isFzf = vim.fn.system('ps -o state= -o comm= | grep -iE \'^[^TXZ ]+ +(\\S+\\/)?fzf$\'') ~= ''
            if isFzf then
              return [[<C-k>]]
            else
              return [[<C-\><C-n><C-w><C-k>]]
            end
          end,
          { buffer = t.bufnr, expr = true }
        )

        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-q>', [[<C-\><C-n><Cmd>q!<Cr>]], { noremap = true })

        -- perform relevant action rather than sending keycodes
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<S-space>', ' ', { noremap = true })
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<S-BS>', '<C-_>', { noremap = true })
      end,
    }
  end
}
