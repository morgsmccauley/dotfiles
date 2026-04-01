return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'Outer function' },
            ['if'] = { query = '@function.inner', desc = 'Inner function' },
            ['ac'] = { query = '@call.outer', desc = 'Outer call' },
            ['ic'] = { query = '@call.inner', desc = 'Inner call' },
            ['aC'] = { query = '@class.outer', desc = 'Outer class' },
            ['iC'] = { query = '@class.inner', desc = 'Inner class' },
            ['a/'] = { query = '@comment.outer', desc = 'Outer comment' },
            ['al'] = { query = '@loop.outer', desc = 'Outer loop' },
            ['il'] = { query = '@loop.inner', desc = 'Inner loop' },
            ['am'] = { query = '@parameter.outer', desc = 'Outer parameter' },
            ['im'] = { query = '@parameter.inner', desc = 'Inner parameter' },
          },
        },
      },
    })

    require('treesitter-context').setup({
      enable = true,
      max_lines = 4,
      trim_scope = 'inner',
      multiline_threshold = 1,
      on_attach = function(bufnr)
        if vim.bo[bufnr].filetype == "markdown" then
          return false
        end

        vim.keymap.set("n", "[c", function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end, { buffer = bufnr, silent = true })

        return true
      end
    })
  end
}
