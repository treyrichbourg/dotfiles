--Colorschemes
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			-- vim.cmd.colorscheme("catppuccin-frappe")
			-- vim.cmd.colorscheme("catppuccin-macchiato")
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-wave",
		lazy = true,
		config = function()
			-- vim.cmd.colorscheme("kanagawa-wave")
			-- vim.cmd.colorscheme("kanagawa-dragon")
			-- vim.cmd.colorscheme("kanagawa-lotus")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			-- vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true,
		config = function()
			-- vim.cmd.colorscheme("tokyonight-night")
			-- vim.cmd.colorscheme("tokyonight-storm")
			-- vim.cmd.colorscheme("tokyonight-moon")
			-- vim.cmd.colorscheme("tokyonight-day")
		end,
	},
}
