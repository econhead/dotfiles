return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            base = "#14161B",
            mantle = "#14161B",
            crust = "#14161B",
          },
        },
        custom_highlights = function(colors)
          math.randomseed(os.time())

          local choices = {
            colors.blue,
            colors.sky,
            colors.sapphire,
            colors.teal,
            colors.green,
            colors.yellow,
            colors.peach,
            colors.maroon,
            colors.red,
            colors.mauve,
            colors.pink,
            colors.lavender,
          }

          local header_color = choices[math.random(#choices)]
          return {
            SnacksDashboardHeader = { fg = header_color },
            SnacksDashboardTitle = { fg = colors.mauve, bold = true },
            SnacksDashboardKey = { fg = colors.peach, bold = true },
            texCmd = { fg = "#d3869b" },
            texMathZone = { fg = "#d06f79" },
            texCmdGreek = { fg = "#d06f79" },
            texMathCmdText = { fg = "#d06f79" },
            texCmdItem = { fg = "#a6e3a1" },
            texPartArgTitle = { fg = "#89b4fa" },
            texArg = { fg = "#a6e3a1" },
            texRefArg = { fg = "#a6e3a1" },
            texMathEnvArgName = { fg = "#a6e3a1" },
            texLength = { fg = "#a6e3a1" },
            texEnvArgName = { fg = "#a6e3a1" },
            texMathCmd = { fg = "#fab387" },
            texMathSymbol = { fg = "#fab387" },
            texMathOper = { fg = "#fab387" },
            texMathDelim = { fg = "#9399b2" },
          }
        end,
      })
      -- vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,

    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })

      -- vim.o.background = "dark"
      -- vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,

    config = function()
      vim.o.background = "dark"

      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd.colorscheme("gruvbox-material")
      local hl = vim.api.nvim_set_hl

      -- General LaTeX commands: Gruvbox blue/teal
      hl(0, "texCmd", { fg = "#80aa9e" })

      -- Greek commands: keep purple as an accent
      hl(0, "texCmdGreek", { fg = "#d3869b" })

      -- Structure
      hl(0, "texCmdItem", { fg = "#b0b846" })
      hl(0, "texCmdPart", { fg = "#b0b846" })
      hl(0, "texPartArgTitle", { fg = "#8bba7f" })

      -- Arguments
      hl(0, "texArg", { fg = "#7daea3" })
      hl(0, "texEnvArgName", { fg = "#7daea3" })
      hl(0, "texMathEnvArgName", { fg = "#7daea3" })
      hl(0, "texLength", { fg = "#7daea3" })

      -- References
      hl(0, "texRefArg", { fg = "#d8a657" })

      -- Mathematics
      hl(0, "texMathZone", { fg = "#d4be98" })
      hl(0, "texMathOper", { fg = "#e78a4e" })

      -- Math commands are orange rather than purple
      hl(0, "texMathCmd", { fg = "#e78a4e" })

      -- Symbols get yellow
      hl(0, "texMathSymbol", { fg = "#d8a657" })

      -- Delimiters / super- and subscripts
      hl(0, "texDelim", { fg = "#ea6962" })
      hl(0, "texMathSuperSub", { fg = "#e78a4e" })
      hl(0, "texMathDelimMod", { fg = "#ea6962" })
      hl(0, "texMathDelim", { fg = "#ea6962" })

      -- Special characters
      hl(0, "texSpecialChar", { fg = "#e78a4e" })

      -- Comments
      hl(0, "texComment", { fg = "#928374", italic = true })
    end,
  }
}
