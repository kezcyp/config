-- hacky stuff to set the default dir
vim.cmd("cd C:/Users/pyczek/Desktop/code")

vim.g.mapleader = ' '

vim.opt.guifont = "Gomono nerd font mono:h10:e-alias"
-- vim.opt.guifont = "Courier New:h12:#e-alias"

vim.opt.title = true
vim.opt.titlestring ="%t"

vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4

vim.opt.cursorline = false
-- vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'

vim.cmd("set number relativenumber")

vim.opt.list = true
-- vim.opt.listchars = {tab = "» ", leadmultispace = "»   ", trail = " "}
vim.opt.listchars = {tab = "| ", leadmultispace = "|   ", trail = " "}
vim.opt.showmatch = true

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
vim.opt.encoding = "utf-8"

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.shadafile = "NONE"
vim.opt.swapfile = false

local remap = vim.keymap.set

-- search center
remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')
-- deleting
remap('n', 'x', '"_x')
remap('v', 'x', '"-x')
-- format pasted lies 
remap('n', 'p', 'p==')

-- page move up/down
remap('n', '<C-k>', '<C-u>zz')
remap('n', '<C-j>', '<C-d>zz')
remap('v', '<C-k>', '<C-u>zz')
remap('v', '<C-j>', '<C-d>zz')
-- move selected lines
remap('v', '<A-k>', ":m '<-2<CR>gv=gv")
remap('v', '<A-j>', ":m '>+1<CR>gv=gv")
remap('n', '<A-j>', ':m .+1<cr>==')
remap('n', '<A-k>', ':m .-2<cr>==')
-- vertical split
remap('n', '<leader>+', '<Cmd>vsplit<CR>')
-- horizontal split
remap('n', '<leader>-', '<Cmd>split<CR>')
-- move in splits with hjkl
remap('n', '<leader>h', '<Cmd>wincmd h<CR>')
remap('n', '<leader>j', '<Cmd>wincmd j<CR>')
remap('n', '<leader>k', '<Cmd>wincmd k<CR>')
remap('n', '<leader>l', '<Cmd>wincmd l<CR>')
remap('t', '<leader>h', '<Cmd>wincmd h<CR>')
remap('t', '<leader>j', '<Cmd>wincmd j<CR>')
remap('t', '<leader>k', '<Cmd>wincmd k<CR>')
remap('t', '<leader>l', '<Cmd>wincmd l<CR>')
-- resize splits
remap('n', '<S-h>', '<Cmd>vertical resize +2<CR>')
remap('n', '<S-j>', '<Cmd>resize +2<CR>')
remap('n', '<S-k>', '<Cmd>resize -2<CR>')
remap('n', '<S-l>', '<Cmd>vertical resize -2<CR>')
-- indent/unindent selected text with tab and shift+tab
remap('v', '>', '>gv')
remap('v', '<', '<gv')
-- remove search HL
remap('n', '<leader>nh', '<Cmd>nohlsearch<CR>')
-- next buffer
remap('n', '<Tab>', '<Cmd>bnext<CR>')
-- previous buffer
remap('n', '<S-Tab>', '<Cmd>bprevious<CR>')
-- quit current buffer
remap('n', '<leader>q', '<Cmd>bd!<CR>')
-- comments with '
remap("n", "'", "<Cmd>norm gcc<CR>")
remap("v", "'", "gc", { remap = true })
-- check allert
remap("n", '<leader>d', "<Cmd>lua vim.diagnostic.open_float()<Cr>")
-- enter shell command
remap("n", '<leader>cc', ":!make")

-- place for 
vim.pack.add({
    {src = "http://github.com/stevearc/oil.nvim"},
    -- themes
    {src = "https://github.com/AlessandroYorba/Alduin"},
    {src = "https://github.com/andreasvc/vim-256noir"},
    {src = "https://github.com/huyvohcmc/atlas.vim"},
    {src = "https://github.com/blazkowolf/gruber-darker.nvim"},
    {src = "https://github.com/rebelot/kanagawa.nvim"},
    {src = "https://github.com/nanotech/jellybeans.vim"},
})

vim.cmd("colorscheme gruber-darker")

remap('n', '<leader>o', ':Oil<CR>')
require("oil").setup({
    default_file_explorer = true,
    view_options = {show_hidden = true},
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end
})
