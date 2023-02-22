return {
  'ggandor/flit.nvim',
  after = 'leap.nvim',
  config = function()
    require 'flit'.setup({
      keys = { f = 'f', F = 'F', t = 't', T = 'T' },
      labeled_modes = 'nv',
      multiline = false,
    })
  end
}
