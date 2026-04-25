return {
  'nvim-lualine/lualine.nvim',
  enabled = not vim.g.vscode,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula'
      }
    })
  end
}
