vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>k', '<cmd>:wincmd k<CR>', {silent = true})
vim.keymap.set('n', '<leader>j', '<cmd>:wincmd j<CR>', {silent = true})
vim.keymap.set('n', '<leader>h', '<cmd>:wincmd h<CR>', {silent = true})
vim.keymap.set('n', '<leader>l', '<cmd>:wincmd l<CR>', {silent = true})

if vim.g.vscode then
    local vscode = require('vscode')

    -- Focus the Explorer (Sidebar)
    vim.keymap.set('n', '<leader>e', [[<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>]])

    -- Focus back to the Editor
    vim.keymap.set('n', '<leader>w', [[<Cmd>call VSCodeNotify('workbench.action.focusActiveEditorGroup')<CR>]])
    
    -- VSCode specific keybindings for NeoVim mode
    -- Normal mode keybindings
    vim.keymap.set('n', 'gp', [[<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>]])
    vim.keymap.set('n', 'gd', [[<Cmd>call VSCodeNotify('editor.action.revealDeclaration')<CR>]])
    vim.keymap.set('n', '<leader>ff', [[<Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>]])
    vim.keymap.set('n', '<leader>ca', [[<Cmd>call VSCodeNotify('editor.action.codeAction')<CR>]])
    vim.keymap.set('n', '<leader>e', [[<Cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>]])
    vim.keymap.set('n', 'K', [[<Cmd>call VSCodeNotify('editor.action.showHover')<CR>]])
    vim.keymap.set('n', '<leader>ne', [[<Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>]])
    vim.keymap.set('n', '<C-o>', [[<Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>]])
    vim.keymap.set('n', '<C-i>', [[<Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>]])
    
    -- Visual mode keybindings
    vim.keymap.set('v', '<leader>fs', [[<Cmd>call VSCodeNotify('editor.action.formatSelection')<CR>]])
else

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

end
