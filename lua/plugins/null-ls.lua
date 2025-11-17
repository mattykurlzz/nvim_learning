return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.cpplint"),
				-- require("none-ls.diagnostics.luacheckr),
				null_ls.builtins.diagnostics.luacheck,
				-- require("none-ls.diagnostics.rust_analyzer"),

				-- require("none-ls.formatting.rust_analyzer"),
				-- null_ls.builtins.formatting.pyproject_fmt,
				-- null_ls.builtins.formatting.luaformatter,
				null_ls.builtins.formatting.clang_format,
			},
		})
	end,
}
