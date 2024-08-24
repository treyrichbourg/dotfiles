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

autocmd("LspAttach", {
	group = comet,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, opts)
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation()
		end, opts)
		vim.keymap.set("n", "<C-k>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<space>wa", function()
			vim.lsp.buf.add_workspace_folder()
		end, opts)
		vim.keymap.set("n", "<space>wr", function()
			vim.lsp.buf.remove_workspace_folder()
		end, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", function()
			vim.lsp.buf.type_definition()
		end, opts)
		vim.keymap.set("n", "<space>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<space>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
