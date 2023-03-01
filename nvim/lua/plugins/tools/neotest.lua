return {
    'nvim-neotest/neotest',
    after = 'neotest-jest',
    requires = {
        {
            'haydenmeade/neotest-jest',
            after = 'neotest-rust'
        },
        {
            'rouge8/neotest-rust',
            module = 'neotest'
        },
    },
    config = function()
      require('neotest').setup({
          adapters = {
              require('neotest-jest')({
                  jestCommand = 'npm test --',
                  cwd = function()
                    return vim.fn.getcwd()
                  end,
              }),
              require('neotest-rust') {
                  args = { '--no-capture' },
              }
          },
          icons = {
              passed = '',
              failed = '',
              running = '',
              skipped = '',
              unknown = ''
          },
          quickfix = {
              enabled = false
          },
          --[[ status = {
            enabled = false,
            signs = false,
            virtual_text = true,
          }, ]]
          output = {
              enabled = false
          }
      })
    end
}
