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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim's runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing your machine's config
						telemetry = {
							enable = false,
						},
					},
				},
			})
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
			})
			require("lspconfig").rust_analyzer.setup({
				capabilities = capabilities,
			})
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
			})
			require("lspconfig").pyproject_fmt.setup({
				capabilities = capabilities,
			})
			require("lspconfig").jsonls.setup({
				capabilities = capabilities,
			})
			--       local coq = require "coq" -- from coq_nvim (gh) addon
			--       lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({}))
			--       lspconfig.clangd.setup(coq.lsp_ensure_capabilities({}))
		end,
	},
}
