local utils = require('utils')

return {
  'morgsmccauley/termbuf.nvim',
  config = function()
    require('termbuf').setup({
      on_open = function(term)
        vim.o.filetype = 'term'

        vim.cmd.startinsert()

        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, buffer = term.bufnr })

        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-l>', function()
          -- using vim api directly to avoid exiting insert mode unnecessarily
          vim.cmd.wincmd('l')
        end, { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-j>', function()
          -- using vim api directly to avoid exiting insert mode unnecessarily
          vim.cmd.wincmd('j')
        end, { noremap = true, buffer = term.bufnr })
        vim.keymap.set('t', '<C-k>', function()
          -- using vim api directly to avoid exiting insert mode unnecessarily
          vim.cmd.wincmd('k')
        end, { noremap = true, buffer = term.bufnr })
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
