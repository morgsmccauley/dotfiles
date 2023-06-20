return {
  'TimUntersberger/neogit',
  cmd = 'Neogit',
  keys = {
    {
      '<C-g>',
      function()
        if vim.bo.filetype == 'NeogitStatus' then
          vim.api.nvim_command('q')
        else
          vim.api.nvim_command('Neogit')
        end
      end,
    }
  },
  config = function()
    require('neogit').setup({
      disable_commit_confirmation = true,
      disable_hint = true,
      disable_insert_on_commit = false,
      integrations = {
        diffview = true
      }
    })
  end,
}
