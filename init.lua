Current_colorscheme = 'kanagawa'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

local plugins = {
    { import = 'plugins' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.appearance' },
    { import = 'plugins.filesystem' },
    { import = 'plugins.text-editing' },
    { import = 'plugins.workflow' },
}

require('lazy').setup(plugins)
require('keymap')
require('set')

local autocmds = require('autocmds')
autocmds.setup_workdir_handling()
autocmds.format_on_save()
autocmds.neotest_output_goto_file_fix()

vim.g.sonokai_enable_italic = 1
vim.cmd.colorscheme(Current_colorscheme)

require('vim._core.ui2').enable({
    enable = true, -- Whether to enable or disable the UI.
    msg = { -- Options related to the message module.
        ---@type 'cmd'|'msg' Default message target, either in the
        ---cmdline or in a separate ephemeral message window.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds and triggers to a target.
        targets = 'cmd',
        cmd = { -- Options related to messages in the cmdline window.
            height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        dialog = { -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
            height = 0.5, -- Maximum height.
            timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
            height = 1, -- Maximum height.
        },
    },
})
