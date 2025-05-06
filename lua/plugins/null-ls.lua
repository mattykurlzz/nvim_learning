return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clangd,
                null_ls.builtins.diagnostics.clangd,
            },
        })

        vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
        vim.keymap.set("", "<leader>fs", function()
            vim.lsp.buf.format({ async = true })
        end, { desc = "[F]ormat" })
    end,
}
