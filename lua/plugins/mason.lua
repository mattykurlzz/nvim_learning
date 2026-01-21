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
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig") -- Import lspconfig
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Global LSP Keymaps (Moved outside of setup tables)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gp", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

            -- You MUST call .setup({}) for each server to start it
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    },
                },
            })

            lspconfig.pyright.setup({
                capabilities = capabilities,
            })

            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd", "--compile-commands-dir=build", "--log=verbose" },
            })

            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            lspconfig.jsonls.setup({ capabilities = capabilities })
        end,
    },
}
