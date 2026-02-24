return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			--yaml = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			cs = { lsp_format = "fallback" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	},
}
