return {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "nvim-lualine/lualine.nvim",
    },
    ft = { "yaml", "json", "jsonc", "toml" },
    opts = {
        builtin_matchers = {
            kubernetes = { enabled = true },
        },
        schemas = {
            {
                name = "Argo CD Application",
                uri =
                "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
            },
            {
                name = "SealedSecret",
                uri =
                "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json",
            },
            {
                name = "Kustomization",
                uri = "https://json.schemastore.org/kustomization.json",
            },
            {
                name = "GitHub Workflow",
                uri = "https://json.schemastore.org/github-workflow.json",
            },
        },
        lspconfig = {
            settings = {
                yaml = {
                    validate = true,
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                },
            },
        },
    },
    config = function(_, opts)
        local lspconfig = vim.lsp.config
        local lualine = require("lualine")
        local telescope = require("telescope")
        local yaml_companion = require("yaml-companion")

        yaml_companion.setup(opts)
        lspconfig["yamlls"].setup(opts.lspconfig)
        telescope.load_extension("yaml_schema")

        -- get schema for current buffer
        local function get_schema()
            local schema = yaml_companion.get_buf_schema(0)
            if schema and schema.result and schema.result[1] and schema.result[1].name ~= "none" then
                return schema.result[1].name
            end
            return ""
        end

        lualine.setup({
            sections = {
                lualine_x = { "fileformat", "filetype", get_schema },
            },
        })
    end,
}
