return {
    {
        "nvim-tree/nvim-web-devicons",
        enabled = not vim.g.vscode,
        opts = {}
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        enabled = not vim.g.vscode,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        opts = {},
    }
}
