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

			vim.lsp.config.lua_ls.settings = {
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
			}
			vim.lsp.config.clangd.settings = {
				capabilities = capabilities,
                cmd = {"clangd", "--compile-commands-dir=build", "--log=verbose"},
			}
			vim.lsp.config.rust_analyzer.settings = {
				capabilities = capabilities,
			}
			vim.lsp.config.pyright.settings = {
				capabilities = capabilities,
			}
			-- vim.lsp.config.pyproject_fmt.settings = {
			-- 	capabilities = capabilities,
			-- }
			vim.lsp.config.jsonls.settings = {
				capabilities = capabilities,
			}
			--       local coq = require "coq" -- from coq_nvim (gh) addon
			--       lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({}))
			--       lspconfig.clangd.setup(coq.lsp_ensure_capabilities({}))
		end,
	},
}
