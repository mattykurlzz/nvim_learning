return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {}),
				vim.keymap.set("n", "gp", vim.lsp.buf.definition, {}),
				vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {}),
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}),
				vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", {
					noremap = true,
					silent = true,
				}),
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lspconfig = require("lspconfig")
            require('lspconfig').lua_ls.setup({
                capabilities = capabilities,
            })
            require('lspconfig').clangd.setup({
                capabilities = capabilities,
            })
            require('lspconfig').rust_analyzer.setup({
                capabilities = capabilities,
            })
			--       local coq = require "coq" -- from coq_nvim (gh) addon
			--       lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({}))
			--       lspconfig.clangd.setup(coq.lsp_ensure_capabilities({}))
		end,
	},
}
