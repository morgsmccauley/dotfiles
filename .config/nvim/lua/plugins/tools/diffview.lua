return {
  'sindrets/diffview.nvim',
  opt = true,
  cmd = 'DiffviewOpen',
  config = function()
    require 'diffview'.setup {
      enhanced_diff_hl = true
    }
  end
}
