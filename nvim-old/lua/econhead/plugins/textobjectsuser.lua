return {
  {
    "kana/vim-textobj-user",
    ft = "tex",
    lazy = false,
    config = function()
      vim.cmd([[
    call textobj#user#plugin('tex', {
    \ 'left-paren': {
    \   'pattern': ['\\left(', '\\right)'],
    \   'select-a': 'aP',
    \   'select-i': 'iP',
    \ },
    \ })
  ]])
    end,
  },
}
