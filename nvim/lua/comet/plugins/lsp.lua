return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "lukas-reineke/lsp-format.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright",
                "lua_ls",
                "tsserver",
                "bashls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end
            },
        })
        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            },
            {
              { name = 'buffer' },
            })
        })
        require("lsp-format").setup({
        })
    end
}
--require('lspconfig').lua_ls.setup({
--    settings = {
--        Lua = {
--            diagnostics = {
--                globals = { 'vim' },
--            },
--        },
--    },
--})
--
--lsp.on_attach(function(client, bufnr)
--    lsp.default_keymaps({ buffer = bufnr })
--    lsp.buffer_autoformat()
--end)
--lsp.setup()
