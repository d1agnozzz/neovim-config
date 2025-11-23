return {
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')

            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.buttons.val = {
                dashboard.button('e', '  New file', '<cmd>ene <CR>'),
                dashboard.button('C-p', '󰈞  Find file', '<cmd>Telescope fd<CR>'),
                dashboard.button('SPC f r', '󰊄  Recently opened files', '<cmd>Telescope oldfiles <CR>'),
                dashboard.button('SPC f g', '󰈬  Find word'),
                dashboard.button('SPC s l', '  Open last session'),
            }

            require('alpha').setup(require('alpha.themes.dashboard').config)
        end,
    },
}
