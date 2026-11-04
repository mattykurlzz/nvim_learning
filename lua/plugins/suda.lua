return {
  "lambdalisue/suda.vim",
  enabled = not vim.g.vscode,
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>W", "<cmd>SudaWrite<cr>", desc = "Save with sudo" },
  },
}
