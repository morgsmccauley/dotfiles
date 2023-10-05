return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  config = function()
    require 'diffview'.setup {
      enhanced_diff_hl = true
    }
  end
}
