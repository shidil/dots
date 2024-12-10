vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selection up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- reposition to center on page jump
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over again and again
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Q noop --
vim.keymap.set("n", "Q", "<Nop>")

-- insert mode navigation
vim.keymap.set("i", "<Up>", "<Nop>")
vim.keymap.set("i", "<Down>", "<Nop>")
vim.keymap.set("i", "<Left>", "<Nop>")
vim.keymap.set("i", "<Right>", "<Nop>")

vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- Tabs
--vim.keymap.set("n", "<Tab>", ">>")
--vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("i", "<S-Tab>", "<Esc><<i")
vim.keymap.set("v", "<Tab>", ">><Esc>gv")
vim.keymap.set("v", "<S-Tab>", "<<<Esc>gv")

-- Buffers
vim.keymap.set("n", "<leader>bc", ":bd ")
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>")
