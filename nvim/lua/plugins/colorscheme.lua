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

      local function latex_highlights()
        local hl = vim.api.nvim_set_hl

        hl(0, "texCmdEnv", { fg = "#ea6962" })
        hl(0, "texDelim", { fg = "#e78a4e" })
        hl(0, "texPartArgTitle", { fg = "#d3869b" })
        hl(0, "texCmdPart", { fg = "#7daea3" })
        hl(0, "texMathEnvArgName", { fg = "#d3869b" })
        hl(0, "texEnvArgName", { fg = "#d3869b" })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.schedule(latex_highlights)
        end,
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.schedule(latex_highlights)
        end,
      })
    end,
  },
}
