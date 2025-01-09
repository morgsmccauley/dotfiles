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
          vim.keymap.set('n', 'g.', files_set_cwd, { buffer = args.data.buf_id })
        end,
      })

      require('mini.files').setup({
        mappings = {
          go_out_plus = 'h',
          go_in_plus = 'l',
          close = '<C-q>'
        }
      })
    end
  }
}
