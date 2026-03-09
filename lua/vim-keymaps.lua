vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>k', '<cmd>:wincmd k<CR>', {silent = true})
vim.keymap.set('n', '<leader>j', '<cmd>:wincmd j<CR>', {silent = true})
vim.keymap.set('n', '<leader>h', '<cmd>:wincmd h<CR>', {silent = true})
vim.keymap.set('n', '<leader>l', '<cmd>:wincmd l<CR>', {silent = true})

vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
vim.keymap.set("", "<leader>fs", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "[F]ormat" })

-- Jump forward in a snippet
vim.keymap.set({ "i", "s" }, "<C-L>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- Jump backward in a snippet
vim.keymap.set({ "i", "s" }, "<C-H>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

-- <c-s> opens terminal

-- Autocomment
vim.keymap.set({'n', 'v'}, '<C-/>', ':AutoInlineComment<CR>')
-- vim.keymap.set({'n', 'v'}, '<C-?>', ':AutoBlockComment<CR>')
