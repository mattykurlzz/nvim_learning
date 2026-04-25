return {
	"akinsho/toggleterm.nvim",
	enabled = not vim.g.vscode,
	event = "VeryLazy",
	version = "*",
	opts = {
		size = 10,
		open_mapping = "<c-s>",
	},
}
