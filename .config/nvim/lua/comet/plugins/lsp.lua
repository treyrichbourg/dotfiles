return {
	"neovim/nvim-lspconfig",
	opts = {
		mason = false,
	},
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"folke/neodev.nvim",
	},
	config = function()
		require("mason").setup()

		-- Capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		---@diagnostic disable-next-line: inject-field
		capabilities.offsetEncoding = { "utf-8" }

		-- LSP keymaps
		local function on_attach(_, bufnr)
			local opts = { buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>")
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<space>f", function()
				if vim.lsp.buf.server_capabilities().documentFormattingProvider then
					vim.lsp.buf.format({ async = true })
				else
					vim.notify("Formatting not supported by attached LSP.")
				end
			end, opts)
		end

		--Language servers
		require("mason-lspconfig").setup({
			ensure_installed = {
				"pyright",
				"lua_ls",
				"ts_ls",
				"bashls",
				"gopls",
			},
		})
		require("mason-lspconfig").setup_handlers({
			--Default handler
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			-- Lua specific
			["lua_ls"] = function()
				require("lspconfig")["lua_ls"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
			-- Go specific
			["gopls"] = function()
				require("lspconfig").gopls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						gopls = {
							buildFlags = { "-tags=e2e,unit" },
							analyses = {
								unusedparams = true,
								nilness = true,
								unusedwrite = true,
								shadow = true,
							},
							staticcheck = true,
							gofumpt = true,
							completeUnimported = true,
							usePlaceholders = false,
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				})
			end,
			-- Python specific
			["pyright"] = function()
				require("lspconfig").pyright.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						python = {
							analyses = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				})
			end,
			-- Typescript specific
			["ts_ls"] = function()
				require("lspconfig").ts_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						javascript = {
							format = { enable = true },
							lint = { enable = true, lintOnSave = true },
						},
						typescript = {
							format = { enable = true },
							lint = { enable = true, lintOnSave = true },
						},
					},
				})
			end,
		})

		--Autocomplete
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
				["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
		})

		--Formatters and Linters
		require("mason-tool-installer").setup({
			ensure_installed = {
				"isort",
				"black",
				"stylua",
				"prettier",
				"pylint",
			},
		})
		vim.g.go_test_flags = "-tags=e2e"
		vim.g.go_cmd_flags = { "-tags=e2e" }
	end,
}
