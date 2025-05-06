vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>k', '<cmd>:wincmd k<CR>', {silent = true})
vim.keymap.set('n', '<leader>j', '<cmd>:wincmd j<CR>', {silent = true})
vim.keymap.set('n', '<leader>h', '<cmd>:wincmd h<CR>', {silent = true})
vim.keymap.set('n', '<leader>l', '<cmd>:wincmd l<CR>', {silent = true})
