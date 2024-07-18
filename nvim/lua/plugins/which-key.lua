return {
  'folke/which-key.nvim',
  keys = { '<leader>', '"', '\'', '`' },
  opts = {
    preset = 'modern',
  },
  init = function()
    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'NONE' })
  end,
  setup = function()
    require("which-key").register({
      ["<leader>"] = {
        w = { name = "+window", ["🚫"] = "which_key_ignore" },
        v = { name = "+view", ["🚫"] = "which_key_ignore" },
      },
    })
  end
}
