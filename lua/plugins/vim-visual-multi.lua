return {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    priority = 1000,
    init = function()
        vim.g.VM_mouse_mappings = true
        vim.g.VM_default_mappings = false -- Use your custom mappings
    end,
    config = function()
        vim.g.VM_maps = {
            ["Find Under"]           = "<C-n>",
            ["Add Cursor Down"]      = "<C-Down>",
            ["Add Cursor Up"]        = "<C-Up>",
            ["Select Cursor Down"]   = "<C-Down>",
            ["Select Cursor Up"]     = "<C-Up>",
        }
    end,
}
