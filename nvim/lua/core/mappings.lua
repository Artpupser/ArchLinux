vim.g.mapleader = " "
--Base
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<CMD>:w<CR>')
vim.keymap.set('i', '<C-z>', '<CMD>:undo<CR>')
vim.keymap.set('i', '<C-S-z>', '<CMD>:rendo<CR>')
--NeoTree
vim.keymap.set('n', '<leader>t', ':Neotree focus<CR>')
vim.keymap.set('n','<leader>o',':Neotree git_status<CR>')

