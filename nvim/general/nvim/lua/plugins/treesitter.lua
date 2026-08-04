return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		-- main ブランチでの新しい書き方（.configs は不要）
		require("nvim-treesitter").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash" },
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
