return {
  'jackMort/ChatGPT.nvim',
  cmd = {
    'ChatGPT',
    'ChatGPTEditWithInstructions',
    'ChatGPTActAs',
    'ChatGPTRun',
    'ChatGPTCompleteCode'
  },
  config = function()
    require('chatgpt').setup({
      api_key_cmd = 'op read op://Personal/4hquyhy7xohsi6zr4lhkkdezoa/key --no-newline',
      openai_params = {
        model = 'gpt-3.5'
      },
    })
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  }
}
