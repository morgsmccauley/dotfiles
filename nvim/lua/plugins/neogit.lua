-- TODO add default args, i.e. commit --no-verify
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
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NeogitPopup",
      callback = function()
        if vim.fn.bufname():match("NeogitCommitPopup") then
          vim.fn.feedkeys("-h")
        end
      end,
    })

    require('neogit').setup({
      disable_commit_confirmation = true,
      disable_hint = true,
      disable_insert_on_commit = "auto",
      remember_settings = false,
      console_timeout = 10000,
      auto_show_console = false,
      integrations = {
        diffview = true,
        telescope = true
      },
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      mappings = {
        finder = {
          ["<c-j>"] = "Next",
          ["<c-k>"] = "Previous"
        },
        rebase_editor = {
          ["<cr>"] = "OpenCommit",
          -- seems to break all maps
          -- ["p"] = false,
          -- ["r"] = false,
          -- ["e"] = false,
          -- ["s"] = false,
          -- ["f"] = false,
          -- ["x"] = false,
          -- ["d"] = false,
          -- ["b"] = false,
          -- ["q"] = false,
        },
      },
      sections = {
        recent = {
          folded = false,
          hidden = false,
        },
      },
      commit_editor = {
        staged_diff_split_kind = "auto"
      },
      popup = {
        kind = "split",
      },
      commit_popup = {
        kind = "split",
        defaults = {
          ["a"] = "commit --amend",
          ["A"] = "commit --amend --no-verify",
          ["c"] = "commit --no-verify",
          ["C"] = "commit",
        },
      },
    })
  end,
}
