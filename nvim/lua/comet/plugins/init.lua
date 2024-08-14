return {
    {
        'nvim-lua/plenary.nvim',
        name = "plenary"
    },
    --Fuzzy Finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { "plenary" }
    },
    --Base Addons
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
    },
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'psf/black',
}
