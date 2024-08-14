return {
    --Colorschemes
    {
        'catppuccin/nvim',
        name = 'catppuccin',
    },
    {
        'rebelot/kanagawa.nvim',
        name = 'kanagawa-wave',
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
    },
    --Options
    --Kanagawa
    --wave = "colorscheme kanagawa-wave",
    --dragon = "colorscheme kanagawa-dragon",
    --lotus = "colorscheme kanagawa-lotus",
    --Catppuccin
    --mocha = "colorscheme catppuccin-mocha",
    --frappe = "colorscheme catppuccin-frappe",
    --macchiato = "colorscheme catppuccin-macchiato",
    --latte = "colorscheme catppuccin-latte",
    --Rose Pine
    --rose = "colorscheme rose-pine",
}

