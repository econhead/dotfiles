return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,

    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme("gruvbox-material")
      local hl = vim.api.nvim_set_hl

      -- Custom LaTeX overrides
      hl(0, "texCmdEnv", { fg = "#ea6962" })
      hl(0, "texDelim", { fg = "#e78a4e" })
    end,
  }
}
