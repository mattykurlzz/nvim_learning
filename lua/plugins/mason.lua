return {
    {
        "williamboman/mason.nvim",
        enabled = not vim.g.vscode,
        priority = 1000,
        lazy = false,
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "nvimtools/none-ls.nvim",
            -- "jay-babu/mason-null-ls.nvim",
            "someone-stole-my-name/yaml-companion.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            -- 1. MASON SETUP
            require("mason").setup()
            local mlp = require("mason-lspconfig")

            -- 2. CAPABILITIES (Fix position encoding mismatch)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-16" }

            -- 3. SHARED ON_ATTACH
            local on_attach = function(client, bufnr)
                vim.notify("LSP " .. client.name .. " attached", vim.log.levels.INFO)
                
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
                
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end

            -- 4. LSP HANDLERS (only real LSP servers)
            mlp.setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "jsonls",
                    "yamlls",
                    -- NOTE: null-ls is NOT here - it's handled separately
                },
                handlers = {
                    -- CLANGD
                    ["clangd"] = function()
                        vim.lsp.start({
                            name = "clangd",
                            cmd = {
                                "clangd",
                                "--clang-tidy",
                                "--clang-tidy-checks=*",
                                "--compile-commands-dir=" .. vim.fn.getcwd(),
                                "--background-index",
                                "--header-insertion=iwyu",
                                "--completion-style=detailed",
                                "--function-arg-placeholders",
                                "--log=verbose",
                                "--offset-encoding=utf-16",
                            },
                            capabilities = capabilities,
                            on_attach = on_attach,
                            init_options = {
                                usePlaceholders = true,
                                completeUnimported = true,
                                clangdFileStatus = true,
                            },
                            root_dir = vim.fs.dirname(vim.fs.find({
                                ".clangd", ".clang-tidy", ".clang-format",
                                "compile_commands.json", "compile_flags.txt", ".git",
                            }, { upward = true })[1]),
                        })
                    end,

                    -- LUA_LS
                    ["lua_ls"] = function()
                        vim.lsp.start({
                            name = "lua_ls",
                            cmd = { "lua-language-server" },
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                    },
                                    telemetry = { enable = false },
                                },
                            },
                            root_dir = vim.fs.dirname(vim.fs.find({
                                ".luarc.json", ".luarc.jsonc", ".git",
                            }, { upward = true })[1]),
                        })
                    end,

                    -- PYRIGHT
                    ["pyright"] = function()
                        vim.lsp.start({
                            name = "pyright",
                            cmd = { "pyright-langserver", "--stdio" },
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
                            root_dir = vim.fs.dirname(vim.fs.find({
                                "pyproject.toml", "setup.py", ".git",
                            }, { upward = true })[1]),
                        })
                    end,

                    -- RUST_ANALYZER
                    ["rust_analyzer"] = function()
                        vim.lsp.start({
                            name = "rust_analyzer",
                            cmd = { "rust-analyzer" },
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                ["rust-analyzer"] = {
                                    checkOnSave = { command = "clippy" },
                                    cargo = { allFeatures = true },
                                },
                            },
                            root_dir = vim.fs.dirname(vim.fs.find({
                                "Cargo.toml", ".git",
                            }, { upward = true })[1]),
                        })
                    end,

                    -- JSONLS
                    ["jsonls"] = function()
                        vim.lsp.start({
                            name = "jsonls",
                            cmd = { "vscode-json-language-server", "--stdio" },
                            capabilities = capabilities,
                            on_attach = on_attach,
                            init_options = { provideFormatter = true },
                            root_dir = vim.fs.dirname(vim.fs.find({
                                ".git",
                            }, { upward = true })[1]),
                        })
                    end,

                    -- YAMLLS
                    ["yamlls"] = function()
                        local yaml_settings = require("yaml-companion").setup({
                            lspconfig = {
                                capabilities = capabilities,
                                on_attach = on_attach,
                                settings = {
                                    yaml = {
                                        validate = true,
                                        format = { enable = true },
                                    },
                                },
                            },
                        })
                        
                        vim.lsp.start({
                            name = "yamlls",
                            cmd = { "yaml-language-server", "--stdio" },
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = yaml_settings.settings or {
                                yaml = {
                                    validate = true,
                                    format = { enable = true },
                                },
                            },
                            root_dir = vim.fs.dirname(vim.fs.find({
                                ".git",
                            }, { upward = true })[1]),
                        })
                    end,
                    
                    -- IMPORTANT: Default handler for any other LSP servers
                    -- This prevents errors for servers you might add later
                    function(server_name)
                        vim.lsp.start({
                            name = server_name,
                            capabilities = capabilities,
                            on_attach = on_attach,
                            root_dir = vim.fs.dirname(vim.fs.find({
                                ".git",
                            }, { upward = true })[1]),
                        })
                    end,
                },
            })

            -- 5. NONE-LS SETUP (handled separately - NOT an LSP)
            -- local null_ls = require("null-ls")
            -- require("mason-null-ls").setup({
                -- ensure_installed = { "black", "luacheck", "clang-format" },
                -- automatic_installation = true,
            -- })
            -- null_ls.setup({
                -- sources = {
                    -- null_ls.builtins.formatting.black,
                    -- null_ls.builtins.formatting.clang_format,
                    -- null_ls.builtins.diagnostics.luacheck,
                -- },
            -- })

            -- 6. TELESCOPE EXTENSION
            require("telescope").load_extension("yaml_schema")
        end,
    },
}
