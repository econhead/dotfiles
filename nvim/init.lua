require("econhead.core")
require("econhead.lazy")
vim.g.python3_host_prog = "/Users/econhead/sympy-venv/bin/python"

require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })
require("luasnip").config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local pdf_path = vim.fn.expand("<afile>:p")
    vim.fn.jobstart({ "sioyek", pdf_path }, { detach = true })
    vim.cmd("silent! bwipeout")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VimtexEventViewReverse",
  callback = function()
    vim.fn.system("open -a WezTerm")
    vim.cmd("redraw!")
  end,
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
