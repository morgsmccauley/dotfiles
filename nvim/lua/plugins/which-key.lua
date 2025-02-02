return {
  'folke/which-key.nvim',
  keys = { '<leader>', '"', '\'', '`' },
  opts = {
    preset = 'modern',
  },
  init = function()
    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'NONE' })
  end,
  config = function()
    local wk = require("which-key")

    wk.register({
      ["<leader>"] = {
        w = { name = "+window" },
        v = { name = "+view" },
        g = {
          name = "+git",
          h = { name = "+hunk" },
          d = { name = "+diff" },
        },
        d = { name = "+debug" },
        m = { name = "+marks" },
        b = { name = "+buffer" },
        c = { name = "+code" },
        n = { name = "+test" },
        t = { name = "+terminal" },
        f = { name = "+file" },
        a = { name = "+ai" },
      },
    })
  end
}
