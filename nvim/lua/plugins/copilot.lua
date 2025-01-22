return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  dependencies = {
    'giuxtaposition/blink-cmp-copilot',
  },
  config = function()
    require('copilot').setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end
}
