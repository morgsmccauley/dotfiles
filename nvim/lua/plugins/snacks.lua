return {
  'folke/snacks.nvim',
  keys = {
    { '<leader>gro', function() require('snacks').gitbrowse() end, desc = "Open file in remote" },
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
  },
  opts = {
    gitbrowse = {
      enabled = true,
    }
  }
}
