return {
	-- 🌞 Solarized テーマ
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "dark",
			transparent = { enabled = true }, -- ✅ 修正
			styles = {
				comments = { fg = "#839496", italic = false },
				keywords = { italic = false },
				functions = { bold = true },
			},
		},
		config = function(_, opts)
			require("solarized").setup(opts)
			vim.cmd("colorscheme solarized")
		end,
	},

	-- 🌿 Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 900,
		config = function()
			require("gruvbox").setup({ contrast = "soft" })
			--			vim.cmd("colorscheme gruvbox")
		end,
	},
}
