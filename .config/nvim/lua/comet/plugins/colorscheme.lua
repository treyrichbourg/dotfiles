--Colorschemes
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			mocha = "colorscheme catppuccin-mocha"
			frappe = "colorscheme catppuccin-frappe"
			macchiato = "colorscheme catppuccin-macchiato"
			latte = "colorscheme catppuccin-latte"
			vim.cmd(macchiato) --Active
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-wave",
		config = function()
			wave = "colorscheme kanagawa-wave"
			dragon = "colorscheme kanagawa-dragon"
			lotus = "colorscheme kanagawa-lotus"
			--			vim.cmd(wave) --Active
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			rose = "colorscheme rose-pine"
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		config = function()
			night = "colorscheme tokyonight-night"
			storm = "colorscheme tokyonight-storm"
			moon = "colorscheme tokyonight-moon"
			day = "colorscheme tokyonight-day"
			--vim.cmd(night)
		end,
	},
}
