return {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
        'haydenmeade/neotest-jest',
        'rouge8/neotest-rust',
        'nvim-neotest/neotest-plenary'
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
                },
                require('neotest-plenary')
            },
            --[[ diagnostic = {
                enabled = true,
            }, ]]
            icons = {
                passed = '',
                failed = '',
                running = '',
                skipped = '',
                unknown = ''
            },
            summary = {
                open = 'topleft vsplit | vertical resize 50'
            },
            quickfix = {
                enabled = false
            },
            --[[ status = {
                enabled = true,
                signs = false,
                virtual_text = true,
            }, ]]
            output = {
                enabled = false
            }
        })
    end
}
