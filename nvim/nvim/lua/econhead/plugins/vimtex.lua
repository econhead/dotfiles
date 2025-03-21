return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_view_sioyek_exe = "/Applications/sioyek.app/Contents/MacOS/sioyek"
    -- vim.g.vimtex_view_sioyek_options = "--reuse-window"
    -- vim.g.vimtex_view_skim_sync = 1
    -- vim.g.vimtex_view_skim_activate = 1
    -- vim.g.vimtex_view_skim_reading_bar = 1
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull",
      "Overfull",
    }
    vim.o.conceallevel = 0
    vim.g.tex_conceal = "abdmg"
    vim.g.vimtex_view_forward_search_on_start = 0
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "/Users/econhead/.texfiles/",
    }
    vim.g.vimtex_quickfix_mode = 1
  end,
}
