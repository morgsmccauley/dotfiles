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

    wk.add({
      { "<leader>a",  group = "ai" },
      { "<leader>b",  group = "buffer" },
      { "<leader>c",  group = "code" },
      { "<leader>d",  group = "debug" },
      { "<leader>f",  group = "file" },
      { "<leader>g",  group = "git" },
      { "<leader>gd", group = "diff" },
      { "<leader>gh", group = "hunk" },
      { "<leader>m",  group = "marks" },
      { "<leader>n",  group = "test" },
      { "<leader>t",  group = "terminal" },
      { "<leader>v",  group = "view" },
      { "<leader>w",  group = "window" },
    })
  end
}
