return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		-- lets nvim-cmp use luasnip as a snippet source
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		require("comet.snippits.unity")
	end,
}
