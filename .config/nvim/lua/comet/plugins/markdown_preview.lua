return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	ft = { "markdown" },
	init = function()
		-- Only load for markdown files
		vim.g.mkdp_filetypes = { "markdown" }

		-- Optional: configure browser explicitly
		-- vim.g.mkdp_browser = "firefox"  -- or "chrome", etc.

		-- Optional: other defaults from README
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_echo_preview_url = 1
		vim.g.mkdp_browser = "chrome"
	end,
}
