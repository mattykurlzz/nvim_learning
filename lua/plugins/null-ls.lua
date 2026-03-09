return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local null_ls_utils = require("null-ls.utils")

        require("mason-null-ls").setup({
            ensure_installed = { "black", "luacheck", "clang-format" },
            automatic_installation = true,
        })

        null_ls.setup({
            -- This ensures null-ls attaches even if you aren't in a git repo
            root_dir = null_ls_utils.root_pattern(".git", "pyproject.toml", "setup.py", "main.py", "package.json",
                ".neoconf.json"),

            sources = {
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.diagnostics.luacheck,
            },
        })
    end,
}
