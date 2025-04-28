return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  opts = {
    -- fill any relevant options here
  },
  config = function()
    vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal left<CR>', {})
  end
}



