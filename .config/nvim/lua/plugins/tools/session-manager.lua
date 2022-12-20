return {
  'Shatur/neovim-session-manager',
  config = function()
    require('session_manager').setup {
      autosave_ignore_filetypes = {
        'toggleterm'
      }
    }

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'SessionSavePost',
      command = 'clearjumps'
    })
  end,
}
