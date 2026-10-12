return {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    delay = 1000
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
