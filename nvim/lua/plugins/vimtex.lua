return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura_simple"
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull",
      "Overfull",
    }
    vim.o.conceallevel = 0
    vim.g.tex_conceal = "abdmg"
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "/home/econhead/.texfiles/",
    }
    vim.g.vimtex_quickfix_mode = 1
  end,
}
