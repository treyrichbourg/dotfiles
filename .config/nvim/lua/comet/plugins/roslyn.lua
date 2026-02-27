return {
	"seblyng/roslyn.nvim",
	ft = { "cs" },
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = {
		filewatching = "off",
		lock_target = true,
		broad_search = false,
	},
	config = function(_, opts)
		require("roslyn").setup(opts)

		vim.lsp.config("roslyn", {
			capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				{
					textDocument = {
						diagnostic = { dynamicRegistration = true },
					},
					offsetEncoding = { "utf-8" },
				}
			),
			settings = {
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles",
				},
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_parameters = true,
				},
			},
		})

		-- Diagnostic refresh on InsertLeave
		vim.api.nvim_create_autocmd("InsertLeave", {
			pattern = "*.cs",
			callback = function()
				local clients = vim.lsp.get_clients({ name = "roslyn" })
				if not clients or #clients == 0 then
					return
				end
				local client = clients[1]
				local buffers = vim.lsp.get_buffers_by_client_id(client.id)
				for _, buf in ipairs(buffers) do
					local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
					client:request("textDocument/diagnostic", params, nil, buf)
				end
			end,
		})

		-- Auto insert for // comments
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local bufnr = args.buf
				if client and client.name == "roslyn" then
					vim.api.nvim_create_autocmd("InsertCharPre", {
						desc = "Roslyn: Trigger auto insert on '/'",
						buffer = bufnr,
						callback = function()
							if vim.v.char ~= "/" then
								return
							end
							local row, col = unpack(vim.api.nvim_win_get_cursor(0))
							row, col = row - 1, col + 1
							local params = {
								_vs_textDocument = { uri = vim.uri_from_bufnr(bufnr) },
								_vs_position = { line = row, character = col },
								_vs_ch = "/",
								_vs_options = {
									tabSize = vim.bo[bufnr].tabstop,
									insertSpaces = vim.bo[bufnr].expandtab,
								},
							}
							vim.defer_fn(function()
								client:request("textDocument/_vs_onAutoInsert", params, function(err, result)
									if err or not result then
										return
									end
									vim.snippet.expand(result._vs_textEdit.newText)
								end, bufnr)
							end, 1)
						end,
					})
				end
			end,
		})

		-- Remove unnecessary usings command
		vim.api.nvim_create_user_command("CSFixUsings", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ name = "roslyn" })
			if not clients or vim.tbl_isempty(clients) then
				vim.notify("Couldn't find roslyn client", vim.log.levels.ERROR)
				return
			end
			local client = clients[1]
			client:request("codeAction/resolve", {
				kind = "quickfix",
				data = {
					CustomTags = { "RemoveUnnecessaryImports" },
					TextDocument = { uri = vim.uri_from_bufnr(bufnr) },
					CodeActionPath = { "Remove unnecessary usings" },
					Range = {
						["start"] = { line = 0, character = 0 },
						["end"] = { line = 0, character = 0 },
					},
					UniqueIdentifier = "Remove unnecessary usings",
				},
			}, function(err, resolved_action)
				if err then
					vim.notify("Fix usings failed", vim.log.levels.ERROR)
					return
				end
				vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
			end)
		end, { desc = "Remove unnecessary using directives" })
	end,
}
