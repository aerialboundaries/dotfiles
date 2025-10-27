return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
			name = "lldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
		}
		-- ✨ C言語のデバッグを有効にする設定を追加！
		-- C言語のデバッグもC++と同じ設定を使うように指示します。
		dap.configurations.c = dap.configurations.cpp
	end,
}
