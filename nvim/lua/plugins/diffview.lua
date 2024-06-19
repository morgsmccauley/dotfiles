return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  config = function()
    local diffview = require('diffview')
    require('diffview').setup {
      enhanced_diff_hl = true,
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      file_panel = {
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      keymaps = {
        view = {
          ['<C-q>'] = diffview.close,
        },
        file_panel = {
          ['<C-q>'] = diffview.close,
        },
        file_history_panel = {
          ['<C-q>'] = diffview.close,
        },
      }
    }
  end
}
