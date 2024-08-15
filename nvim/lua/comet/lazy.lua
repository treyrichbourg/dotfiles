-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("comet.plugins")

-- --LSP
-- use { "jose-elias-alvarez/null-ls.nvim" }
-- use()
-- use {
--     'VonHeikemen/lsp-zero.nvim',
--     branch = 'v2.x',
--     requires = {
--         -- LSP Support
--         { 'neovim/nvim-lspconfig' }, -- Required
--         {
--             -- Optional
--             'williamboman/mason.nvim',
--             run = function()
--                 pcall(vim.cmd, 'MasonUpdate')
--             end,
--         },
--         { 'williamboman/mason-lspconfig.nvim' }, -- Optional

--         -- Autocompletion
--         { 'hrsh7th/nvim-cmp' },     -- Required
--         { 'hrsh7th/cmp-nvim-lsp' }, -- Required
--         { 'L3MON4D3/LuaSnip' },     -- Required
--     }
-- }
