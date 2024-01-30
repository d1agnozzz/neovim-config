return {
    { 'numToStr/Comment.nvim', opts = {} },
    { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            require('nvim-autopairs').setup()
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                dependencies = {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()

                        local ls = require('luasnip')
                        local fmt = require('luasnip.extras.fmt').fmt
                        local s = ls.snippet
                        local i = ls.insert_node
                        local rep = require('luasnip.extras').rep

                        ls.add_snippets('tex', {
                            s(
                                'img',
                                fmt(
                                    [[
                                \begin{figure}
                                    \centering
                                    \includegraphics[width=\linewidth]{<path>}
                                    \caption{<caption>}
                                    \label{<label>}
                                \end{figure}
                                ]],
                                    { path = i(1, 'path_to_img'), caption = i(2, 'caption'), label = i(3, 'label') },
                                    { delimiters = '<>' }
                                )
                            ),
                        })
                    end,
                },
                -- config = function() end,
            },
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
            end

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip', option = { use_show_condition = false } }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'path' },
                    { name = 'buffer' },
                    { name = 'crates' },
                    {
                        name = 'spell',
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return require('cmp.config.context').in_treesitter_capture('spell')
                            end,
                        },
                    },
                }),
                experimental = {
                    ghost_text = true,
                },
            })

            -- Set configuration for specific filetype.
            -- cmp.setup.filetype('gitcommit', {
            --     sources = cmp.config.sources({
            --         { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            --     }, {
            --         { name = 'buffer' },
            --     }),
            -- })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })
        end,
    },
}
