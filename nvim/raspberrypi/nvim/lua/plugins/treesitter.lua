return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = { "c", "cpp", "lua", "python", "bash", "markdown", "markdown_inline" },
			highlight = { enable = true },
		})
	end,
}
