return {
  'Shatur/neovim-session-manager',
  config = function()
    require('session_manager').setup({
      -- autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
      max_path_length = 1,
      autosave_ignore_filetypes = {
        'Outline',
        'toggleterm'
      },
      autosave_only_in_session = true
    })
  end
}
