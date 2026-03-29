vim.g.mapleader = ' '  

local remap = vim.keymap.set

vim.opt.title = true
vim.opt.titlestring = '%t'

vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4

vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.showcmd = true
vim.opt.timeoutlen = 300
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.completeopt = "menuone,noselect"
vim.opt.updatetime = 50
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'

vim.opt.list = true
vim.opt.listchars = { tab = "  ", leadmultispace = "    ", trail = " " }
vim.opt.showmatch = true

vim.opt.termguicolors = true
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.encoding = "utf-8"

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.cmd("set number relativenumber")

vim.opt.shadafile = "NONE"
vim.opt.swapfile = false

-- Search centering
remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')
-- Deleting to the void
remap('n', 'x', '"_x')
remap('v', 'x', '"_x')
-- Format pasted line
remap('n', 'p', 'p==')

-- Page movement up/down
remap('n', '<C-k>', '<C-u>zz')
remap('n', '<C-j>', '<C-d>zz')
remap('v', '<C-k>', '<C-u>zz')
remap('v', '<C-j>', '<C-d>zz')
-- Move selected lines with alt arrows like in subl
remap('v', '<A-k>', ":m '<-2<CR>gv=gv")
remap('v', '<A-j>', ":m '>+1<CR>gv=gv")
remap('n', '<A-j>', ':m .+1<cr>==')
remap('n', '<A-k>', ':m .-2<cr>==')
-- Vertical split
remap('n', '<leader>+', '<Cmd>vsplit<CR>')
-- Horizontal split
remap('n', '<leader>-', '<Cmd>split<CR>')
-- Move in splits with hjkl
remap('n', '<leader>h', '<Cmd>wincmd h<CR>')
remap('n', '<leader>j', '<Cmd>wincmd j<CR>')
remap('n', '<leader>k', '<Cmd>wincmd k<CR>')
remap('n', '<leader>l', '<Cmd>wincmd l<CR>')
remap('t', '<leader>h', '<Cmd>wincmd h<CR>')
remap('t', '<leader>j', '<Cmd>wincmd j<CR>')
remap('t', '<leader>k', '<Cmd>wincmd k<CR>')
remap('t', '<leader>l', '<Cmd>wincmd l<CR>')
-- Resize splits
remap('n', '<S-h>', '<Cmd>vertical resize +2<CR>')
remap('n', '<S-j>', '<Cmd>resize +2<CR>')
remap('n', '<S-k>', '<Cmd>resize -2<CR>')
remap('n', '<S-l>', '<Cmd>vertical resize -2<CR>')
-- Indent/Unindent selected text with Tab and Shift+Tab
remap('v', '>', '>gv')
remap('v', '<', '<gv')
-- Remove search HL
remap('n', '<leader>nh', '<Cmd>nohlsearch<CR>')
-- Next buffer
remap('n', '<Tab>', '<Cmd>bnext<CR>')
-- Previous buffer
remap('n', '<S-Tab>', '<Cmd>bprevious<CR>')
-- Quit current buffer
remap('n', '<leader>q', '<Cmd>bd!<CR>')
-- Comments with '
remap("n", "'", "<Cmd>norm gcc<CR>")
remap("v", "'", "gc", { remap = true })
-- check allert
remap("n", '<leader>d', "<Cmd>lua vim.diagnostic.open_float()<Cr>")
-- Compile compile-mode 
remap("n", '<leader>cc', "<Cmd>Compile<Cr>")

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)                              

require("lazy").setup({
    {
        'blazkowolf/gruber-darker.nvim',
        config = function()
            vim.cmd('colorscheme gruber-darker') 
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },
    {
        'stevearc/oil.nvim',
        config = function()
            remap('n', '<leader>o', ':Oil<CR>')
            require('oil').setup({
                default_file_explorer = true,
                view_options = { show_hidden = true },
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = vim.lsp.config["luals"]
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            local custom_attach = function(client, bufnr)
                print('Lsp Attached.')
            end
            vim.lsp.enable('clangd')
            vim.lsp.enable('basedpyright')
        end
    },
    {
        'saghen/blink.cmp',
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ["<Esc>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "mason-org/mason.nvim",
        opts ={}
    },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy   = false;
        build = ":TSUpdate";
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'c', 'lua' },
                sync_install = true,
                auto_install = true,
                highlight = {
                    enable = true;
                },
            }
        end 
    },
    {
        "ej-shafran/compile-mode.nvim",
        version = "^5.0.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "m00qek/baleia.nvim", tag = "v1.3.0" },
        },
        config = function()
            ---@type CompileModeOpts
            vim.g.compile_mode = {
                input_word_completion = true,
                baleia_setup = true,
                focus_compilation_buffer = true, 
            }
        end
    },
    {"xiyaowong/transparent.nvim"},
},
{
    ui = {
        border = "rounded"
    }
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end
})
