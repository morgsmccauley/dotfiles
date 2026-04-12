return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ':TSUpdate',
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
    local ensureInstalled = {
      'lua',
      'python',
      'typescript',
      'rust',
      'c',
      'markdown',
      'markdown_inline',
      'vim',
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end,
  config = function()
    require('nvim-treesitter').setup({
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
