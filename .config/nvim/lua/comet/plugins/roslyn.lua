-- lua/plugins/roslyn.lua

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.offsetEncoding = { "utf-8" }

local roslynCapabilities = vim.tbl_deep_extend("force", capabilities, {
	textDocument = {
		diagnostic = {
			dynamicRegistration = true,
		},
	},
})

return {
	"seblyng/roslyn.nvim",
	ft = { "cs" },
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	---@module "roslyn.config"
	---@type RoslynNvimConfig
	opts = {
		capabilities = roslynCapabilities,

		inlay_hints = {
			enabled = true,
			parameter_names = true,
			variable_types = true,
		},

		diagnostics = {
			enabled = true,
		},

		code_actions = true,

		config = {
			settings = {
				["dotnet_analyzer_diagnostic"] = {
					severity = "suggestion",
				},
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles",
				},
			},
		},
	},
}
