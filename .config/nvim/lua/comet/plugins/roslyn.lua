return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	opts = {
		inlay_hints = {
			enabled = true,
			parameter_names = true,
			variable_types = true,
		},
		diagnostics = {
			enabled = true,
		},
		code_actions = true,
	},
}
