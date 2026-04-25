return {
    {
        "neovim/nvim-lspconfig",
        enabled = not vim.g.vscode,
        priority = 1000,
        lazy = false,
        dependencies = {
            -- LSP Management
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            -- Formatting/Linting
            "nvimtools/none-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
            -- YAML / JSON Companion
            "someone-stole-my-name/yaml-companion.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            -- 1. MASON SETUP
            require("mason").setup()
            local mlp = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            
            -- 2. CAPABILITIES (The Position Encoding Fix)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- Force UTF-16 globally to match null-ls and stop the warning
            capabilities.offsetEncoding = { "utf-16" }

            mlp.setup({
                ensure_installed = { "clangd", "lua_ls", "pyright", "rust_analyzer", "jsonls", "yamlls" },
            })

            -- 3. SHARED ON_ATTACH
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            end

            -- 4. INDIVIDUAL SERVER SETUPS
            
            -- Forced Clangd Setup
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--clang-tidy",
                    "--background-index",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--offset-encoding=utf-16", -- Physical override for the binary
                },
            })

            -- YAML Companion Setup
            local yaml_cfg = require("yaml-companion").setup({
                lspconfig = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = { yaml = { validate = true } },
                },
            })
            lspconfig.yamlls.setup(yaml_cfg)

            -- Other Servers
            local servers = { "lua_ls", "pyright", "rust_analyzer", "jsonls" }
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end

            -- 5. NONE-LS (NULL-LS) SETUP
            local null_ls = require("null-ls")
            require("mason-null-ls").setup({
                ensure_installed = { "black", "luacheck", "clang-format" },
                automatic_installation = true,
            })
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.diagnostics.luacheck,
                },
            })

            -- 6. TELESCOPE EXTENSION
            require("telescope").load_extension("yaml_schema")
        end,
    },
}
