return {
  dir = '~/Developer/termbuf.nvim',
  config = function()
    require('termbuf').setup({
      on_open = function(term)
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, buffer = term.bufnr })

        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true, buffer = term.bufnr })
        -- TODO check if there is a window to the left, otherwise clear
        -- vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W><C-l>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-w><C-h>', [[<Cmd>tabprev<Cr>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-w><C-l>', [[<Cmd>tabnext<Cr>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-o>', [[<C-\><C-n><C-o>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-i>', [[<C-\><C-n><C-i>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-q>', [[<C-\><C-n><Cmd>silent q<Cr>]], { noremap = true, buffer = term.bufnr })

        vim.keymap.set('t', '<S-space>', ' ', { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<S-BS>', '<C-_>', { noremap = true, buffer = term.bufnr })
      end,
      on_enter = function()
        vim.cmd.startinsert()
      end,
    })
  end
}
