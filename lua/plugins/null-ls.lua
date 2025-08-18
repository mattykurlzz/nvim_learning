return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,

				null_ls.builtins.formatting.clang_format,
				require("none-ls.diagnostics.cpplint"),

				--				null_ls.builtins.formatting.rust_analyzer,
				--				null_ls.builtins.diagnostics.rust_analyzer,

				null_ls.builtins.formatting.black,
			},
		})
	end,
}
