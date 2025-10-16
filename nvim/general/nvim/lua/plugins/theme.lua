return {
	-- 🌞 Solarized テーマ
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "dark",
			transparent = { enabled = false }, -- ✅ 修正
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
			},
		},
		config = function(_, opts)
			require("solarized").setup(opts)
			vim.cmd("colorscheme solarized")

			-- My config
			---- コメントの色を明るい灰色（#93a1a1）に上書き
			vim.api.nvim_set_hl(0, "Comment", { fg = "#839496" })
			-- ここまでMy config
		end,
	},

	-- 🌿 Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 900,
		config = function()
			require("gruvbox").setup({ contrast = "soft" })
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
