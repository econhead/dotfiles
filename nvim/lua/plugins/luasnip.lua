return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",

	config = function()
		local ls = require("luasnip")

		ls.config.set_config({
			enable_autosnippets = true,
			store_selection_keys = "<Tab>",
			update_events = "TextChanged,TextChangedI",
		})

		require("luasnip.loaders.from_lua").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/LuaSnip" },
		})
		vim.keymap.set({ "i" }, "<Tab>", function()
			ls.expand()
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "jk", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			ls.jump(-1)
		end, { silent = true })
	end,
}
