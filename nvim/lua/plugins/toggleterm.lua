return {
  'akinsho/toggleterm.nvim',
  keys = {
    {
      '<C-t>',
      '<Cmd>exe v:count1 . "ToggleTerm"<Cr>',
      silent = true,
      noremap = true
    },
    {
      '<C-s-t>',
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        Terminal:new({ hidden = true, direction = 'tab' }):toggle()
      end,
    }
  },
  cmd = { 'TermExec' },
  config = function()
    vim.api.nvim_create_autocmd({ 'DirChanged' }, {
      pattern = 'global',
      callback = function()
        local terms = require('toggleterm.terminal')

        local current_winnr = vim.fn.winnr()

        for _, terminal in ipairs(terms.get_all(true)) do
          terminal:change_dir(vim.fn.expand('<afile>'), true)
        end

        vim.cmd(current_winnr .. 'wincmd w')
      end
    })

    local function isInteractive()
      local interative_cli_apps = { 'fzf', 'near', 'gh' }
      return vim.fn.system(
            "ps -o state= -o comm= | grep -iE '^[^TXZ ]+ +(\\S+\\/)?(" .. table.concat(interative_cli_apps, '|') .. ")$'") ~=
          ''
    end

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

        vim.keymap.set(
          't',
          '<C-j>',
          function()
            if isInteractive() then
              return [[<Down>]]
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
            if isInteractive() then
              return [[<Up>]]
            else
              return [[<C-\><C-n><C-w><C-k>]]
            end
          end,
          { buffer = t.bufnr, expr = true }
        )

        vim.keymap.set(
          't',
          '<C-S-t>',
          function()
            local Terminal = require('toggleterm.terminal').Terminal
            Terminal:new({ hidden = true, direction = 'tab' }):toggle()
          end,
          { buffer = t.bufnr }
        )

        vim.keymap.set(
          't',
          '<C-.>',
          '<Cmd>tabnext<Cr>',
          { buffer = t.bufnr }
        )

        vim.keymap.set(
          't',
          '<C-,>',
          '<Cmd>tabprev<Cr>',
          { buffer = t.bufnr }
        )

        vim.keymap.set(
          'n',
          '<C-p>',
          '?^❯<Cr>:noh<Cr>',
          { buffer = t.bufnr }
        )

        vim.keymap.set(
          'n',
          '<C-n>',
          '/^❯<Cr>:noh<Cr>',
          { buffer = t.bufnr }
        )


        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-q>', [[<C-\><C-n><Cmd>q!<Cr>]], { noremap = true })

        -- perform relevant action rather than sending keycodes
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<S-space>', ' ', { noremap = true })
        vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<S-BS>', '<C-_>', { noremap = true })
      end,
    }
  end
}
