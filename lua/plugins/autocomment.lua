return {
    "KarimElghamry/vim-auto-comment",
    event = "BufReadPost",
    config = function()
        local status_ok, autocomment = pcall(require, "vim-auto-comment")
        if not status_ok then
            return
        end

        autocomment.setup({
            python = "# ",
            rust = "// ",
            cpp = "// ",
            c = "// ",
            bash = "# ",
            sh = "# ",

            lua = "-- ",
            toml = "# ",
            yaml = "# ",
            json = "// ",
            javascript = "// ",
            typescript = "// ",
            sql = "-- ",
            vim = '" ',
        })
    end,
}
