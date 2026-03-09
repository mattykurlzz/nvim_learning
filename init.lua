require("config.lazy")
vim.opt.mouse = ""
vim.wo.number = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local wrap_filetypes = { "markdown", "text", "tex", "plaintext" }
    if vim.tbl_contains(wrap_filetypes, vim.bo.filetype) then
      vim.opt_local.wrap = true
    else
      vim.opt_local.wrap = false
    end
  end,
})
