return {
  "nvim-treesitter/nvim-treesitter",
  enabled = not vim.g.vscode,
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    treesitter.install({
      "bash",
      "c",
      "cpp",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "vim",
      "vimdoc",
      "yaml",
    })

    local parsers = {
      bash = true,
      c = true,
      cpp = true,
      json = true,
      lua = true,
      markdown = true,
      markdown_inline = true,
      python = true,
      vim = true,
      vimdoc = true,
      yaml = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = vim.tbl_keys(parsers),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf, "highlight")
        pcall(vim.treesitter.start, args.buf, "indent")
      end,
    })
  end,
}
