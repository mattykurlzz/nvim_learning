return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    enabled = not vim.g.vscode,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
}
