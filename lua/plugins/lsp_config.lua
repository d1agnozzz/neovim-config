return function() local on_attach = require('keymap.lsp')

local lspconfig = require('lspconfig')
lspconfig["lua_ls"].setup {
    on_attach = on_attach
}
lspconfig.rust_analyzer.setup {
    on_attach = on_attach
}
end
