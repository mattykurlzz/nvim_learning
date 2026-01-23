return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup({
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '┃' },
        topdelete    = { text = '' },
        changedelete = { text = '' },
        untracked    = { text = '┆' },
      },
      -- To make it even MORE like VS Code, you can enable these:
      current_line_blame = true, -- Shows who changed the line
      signcolumn = true,         -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false,        -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false,        -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false,        -- Toggle with `:Gitsigns toggle_word_diff`
    })
  end
}
