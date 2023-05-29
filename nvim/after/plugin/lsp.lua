local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'pyright',
    'lua_ls'

})

require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

lsp.setup()

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    },
})
