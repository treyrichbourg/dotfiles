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

--Tell Treesitter to parse yaml templates as helm when I'm working in any
--project containing a Chart.yaml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.yaml", "*.yml", "*.tpl" },
    callback = function()
        local filepath = vim.fn.expand("%:p")
        if filepath:match("/templates/") then
            -- check for Chart.yaml in parent directories
            local chart = vim.fn.findfile("Chart.yaml", vim.fn.expand("%:p:h") .. ";")
            if chart ~= "" then
                vim.bo.filetype = "helm"
            end
        end
    end,
})
