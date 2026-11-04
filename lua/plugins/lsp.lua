return {
    -- LSP servers
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-16" }

            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                -- NOTE: conform.nvim's format_on_save handles some on_attach's functions
            end

            -- yaml-companion drives yamlls
            require("yaml-companion").setup({
                lspconfig = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = { yaml = { validate = true, format = { enable = true } } },
                },
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        telemetry = { enable = false },
                    },
                },
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                        cargo = { features = "all" },
                    },
                },
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                init_options = { provideFormatter = true },
            })
            lspconfig.biome.setup({
                cmd = { "biome", "lsp-proxy" }, -- <- fixed
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig.nil_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig.nixd.setup({ capabilities = capabilities, on_attach = on_attach })
            -- TODO: comment this? ^^

            lspconfig.dockerls.setup({
                cmd = { "docker-langserver", '--stdio' }, -- <- added --stdio
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig.docker_compose_language_service.setup({
                cmd = { "docker-compose-langserver", '--stdio' }, -- <- fixed binary name
                capabilities = capabilities,
                on_attach = on_attach,
            })

            require("telescope").load_extension("yaml_schema")
        end,
    },

    ------------------------------------------------------------------
    -- 2. Formatters (conform.nvim)
    ------------------------------------------------------------------
    {
        "stevearc/conform.nvim",
        event = { "BufReadPost", "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                nix = { "nixfmt" },
                dockerfile = { "dockerfmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback", -- if no formatter above matches, use LSP
            },
        },
    },

    ------------------------------------------------------------------
    -- 3. Linters (nvim-lint)
    ------------------------------------------------------------------
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost", "InsertLeave" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                nix = { "statix", "deadnix" },
                dockerfile = { "hadolint" },
            }
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
