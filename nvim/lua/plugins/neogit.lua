return {
  'NeogitOrg/neogit',
  -- dir = '~/Developer/neogit',
  cmd = 'Neogit',
  keys = {
    {
      '<C-g>',
      function()
        -- ensure telescope-ui-select is loaded
        require('telescope')

        if vim.bo.filetype == 'NeogitStatus' then
          vim.api.nvim_command('q')
        else
          vim.api.nvim_command('Neogit')
        end
      end,
    },
  },
  config = function()
    require('neogit').setup({
      disable_commit_confirmation = true,
      disable_hint = true,
      disable_insert_on_commit = "auto",
      integrations = {
        diffview = true,
        telescope = true
      },
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      sections = {
        recent = {
          folded = false,
          hidden = false,
        },
      },
    })
  end,
}
