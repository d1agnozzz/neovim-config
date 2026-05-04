return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            {
                'fredrikaverpil/neotest-golang',
                version = '*', -- Optional, but recommended; track releases
                build = function()
                    vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
                end,
            },
        },
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            {
                'nvim-treesitter/nvim-treesitter', -- Optional, but recommended
                branch = 'main', -- NOTE; not the master branch!
                build = function() vim.cmd(':TSUpdate go') end,
            },
            {
                'fredrikaverpil/neotest-golang',
                version = '*', -- Optional, but recommended; track releases
                build = function()
                    vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
                end,
            },
        },
        config = function()
            local config = {
                runner = 'gotestsum', -- Optional, but recommended
            }
            require('neotest').setup({
                adapters = {
                    require('neotest-golang')(config),
                },
                discovery = {
                    concurrent = 1,
                },
                running = {
                    concurrent = true,
                },
                summary = {
                    animated = false,
                },
            })
        end,
        keys = {
            { '<leader>tt', function() require('neotest').run.run() end, desc = 'test nearest' },
            { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'test file' },
            {
                '<leader>to',
                function() require('neotest').output_panel.toggle({ enter = 1 }) end,
                desc = 'toggle tests output panel',
            },
            {
                '<leader>ts',
                function() require('neotest').summary.toggle({ enter = 1 }) end,
                desc = 'toggle tests summary',
            },
        },
    },
}
