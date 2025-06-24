vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = "\\"

--vim.keymap.set("n", "K", vim.lsp.buf.hover, {}),
--vim.keymap.set("n", "gp", vim.lsp.buf.definition, {}),
--vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {}),
--vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}),
--
--vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
vim.keymap.set("", "<leader>fs", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "[F]ormat" })