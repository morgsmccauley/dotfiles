return {
  'folke/snacks.nvim',
  keys = {
    { '<leader>gro', function() require('snacks').gitbrowse() end,      desc = "Open file in remote" },
    {
      '<leader>gry',
      function()
        require('snacks').gitbrowse.open({
          notify = false,
          open = function(url)
            vim.fn.setreg('*', url)
          end
        })
      end,
      desc = "Copy git remote url"
    },
    {
      '<leader>ff',
      function()
        require('snacks').picker.files()
      end,
      desc = "Find files"
    },
    {
      '<leader>fg',
      function()
        require('snacks').picker.git_files({
          toggles = {
            hidden = true,
            ignored = true,
          }
        })
      end,
      desc = "Find git files"
    },
    { "<leader>fr",  function() require('snacks').picker.recent() end,  desc = "Find recent file" },
    { "<leader>fj",  function() require('snacks').picker.jumps() end,   desc = "Find jump" },
    { "<leader>fs",  function() require('snacks').picker.smart() end,   desc = "Find smart" },
    { "<leader>fb",  function() require('snacks').picker.buffers() end, desc = "Find buffer" },
    {
      "<leader>fu",
      function()
        require('snacks').picker.undo()
      end,
      desc = "File undo"
    },
    {
      "<leader>sb",
      function()
        require('snacks').picker.lines()
      end,
      desc = "Search buffer lines"
    },
    {
      "<leader>sB",
      function()
        require('snacks').picker.lines()
      end,
      desc = "Search open buffers"
    },
    {
      "<leader>sg",
      function()
        require('snacks').picker.grep({
          hidden = true
        })
      end,
      desc = "Grep all files"
    },
    {
      "<leader>sw",
      function()
        require('snacks').picker.grep_word()
      end,
      desc = "Grep selection/word"
    }
  },
  opts = {
    gitbrowse = {
      enabled = true,
    },
    picker = {
      enabled = true,
      layout = { preset = "ivy", position = "bottom" },
      formatters = {
        file = {
          truncate = 1000,
          -- filename_first = true,
        }
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "cancel", mode = { "i", "n" } },
            ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<C-q>"] = { "cancel", mode = { "i", "n" } },
            ["<C-f>"] = { "qflist", mode = { "i", "n" } }
          },
        },
      },
    },
    indent = {
      enabled = false,
      animate = { enabled = false },
      only_scope = true,
      only_current = true,
    }
  }
}
