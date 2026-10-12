return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    },
  },
}
