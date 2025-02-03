return {
  {
    'echasnovski/mini.bracketed',
    version = '*',
    keys = { '[', ']' },
    config = function()
      require('mini.bracketed').setup()
    end,
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    event = 'InsertEnter',
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      local mini_files = require('mini.files')

      local files_set_cwd = function(path)
        local cur_entry_path = mini_files.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        -- FIX: change dir not working even though path is correct
        vim.fn.chdir(cur_directory)
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Set working directory mapping
          vim.keymap.set('n', 'g.', files_set_cwd, { buffer = buf_id })

          -- Set vertical split mapping
          vim.keymap.set('n', '<C-v>', function()
            local fs_entry = mini_files.get_fs_entry()
            if fs_entry == nil then return end
            mini_files.close()
            vim.cmd('vsplit ' .. fs_entry.path)
          end, { buffer = buf_id })
        end,
      })

      require('mini.files').setup({
        mappings = {
          go_out_plus = 'h',
          go_in_plus = 'l',
          close = '<C-q>'
        },
        options = {
          use_as_default_explorer = true,
        },
      })
    end
  }
}
