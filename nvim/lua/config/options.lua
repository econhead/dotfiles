local opt = vim.opt

-- Interface
opt.mouse = ""
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true

-- Editing
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.wrap = false

-- Searching
opt.ignorecase = true
opt.smartcase = true

-- Windows and files
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.clipboard = "unnamedplus"
