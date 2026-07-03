vim.cmd("set wrap")
vim.opt.undofile = true
vim.opt.number = true
--vim.opt.relativenumber = false 
vim.opt.clipboard = "unnamedplus"

--This is so that if there is text that spans more than one line,
-- It will only go up and down one line a t a time
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

--LSP Keymaps

vim.keymap.set("n", "<leader>d" ,vim.diagnostic.open_float) 
vim.keymap.set("n", "<leader>ca" ,vim.lsp.buf.code_action) 
