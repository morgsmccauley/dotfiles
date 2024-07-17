local utils = require('utils')

return {
  dir = '~/Developer/termbuf.nvim',
  config = function()
    require('termbuf').setup({
      on_open = function(term)
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, buffer = term.bufnr })

        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true, buffer = term.bufnr })
        -- TODO check if there is a window to the left, otherwise clear
        vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W><C-l>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-w><C-h>', [[<Cmd>tabprev<Cr>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-w><C-l>', [[<Cmd>tabnext<Cr>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-o>', [[<C-\><C-n><C-o>]], { noremap = true, buffer = term.bufnr })
        -- Prevent conflict with tab
        -- vim.keymap.set('t', '<C-i>', [[<C-\><C-n><C-i>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-q>', [[<C-\><C-n><Cmd>silent q<Cr>]], { noremap = true, buffer = term.bufnr })

        vim.keymap.set('t', '<S-space>', ' ', { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<S-BS>', '<C-_>', { noremap = true, buffer = term.bufnr })

        vim.keymap.set('t', '<C-t><C-t>', function()
          vim.cmd.tabnew()
          require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
        end, { desc = 'Open terminal in new tab' })

        vim.keymap.set('t', '<C-t><C-l>', function()
          vim.cmd.vsplit()
          require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
        end, { desc = 'Open terminal to right' })

        vim.keymap.set('t', '<C-t><C-j>', function()
          vim.cmd('belowright split')
          require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
        end, { desc = 'Open terminal below' })
      end,
      on_enter = function()
        vim.cmd.startinsert()
      end,
    })
  end
}
