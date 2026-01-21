-- In your lazy plugin spec file (e.g., ~/.config/nvim/lua/plugins.lua)
return {
    "RaafatTurki/hex.nvim",
    lazy = false, -- Load immediately, not lazy
    config = function()
        require("hex").setup({
            -- Optional settings
            save_on_toggle = false,
            autoname = false,
            silent = false,
        })
    end,
    keys = {
        { "<leader>hh", "<cmd>HexToggle<CR>", desc = "Toggle Hex Editor" },
        { "<leader>ho", "<cmd>Hex<CR>",       desc = "Open Hex Editor" },
    }
}
