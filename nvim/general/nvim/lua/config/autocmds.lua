-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- C言語およびC++ファイルで、改行時のコメント自動継続を無効にする
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		-- 'r': InsertモードでEnterキーを押したときにコメント記号を自動挿入する
		-- 'o': Normalモードで o や O を押したときにコメント記号を自動挿入する
		vim.opt_local.formatoptions = vim.opt_local.formatoptions - { "r", "o" }
	end,
})
