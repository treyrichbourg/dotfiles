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
