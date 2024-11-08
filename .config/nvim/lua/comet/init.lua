require("comet.remap")
require("comet.set")
require("comet.lazy")

local augroup = vim.api.nvim_create_augroup
local comet = augroup("comet", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

--Removes all trailing whitespace on save
autocmd({ "BufWritePre" }, {
	group = comet,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

--Highlight when yanking text
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- autocmd("LspAttach", {
-- 	group = comet,
-- 	callback = function(e)
-- 		local opts = { buffer = e.buf }
-- 		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- 		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
-- 		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
-- 		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
-- 		vim.keymap.set("n", "<space>wl", function()
-- 			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 		end, opts)
-- 		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
-- 		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
-- 		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
-- 		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- 		vim.keymap.set("n", "<space>f", function()
-- 			if vim.lsp.buf.server_capabilities().documentFormattingProvider then
-- 				vim.lsp.buf.format({ async = true })
-- 			else
-- 				vim.notify("Formatting not supported by attached LSP.")
-- 			end
-- 		end, opts)
-- 	end,
-- })
