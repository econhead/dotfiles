return {
	{
		"ficcdaf/ashen.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("ashen").setup({
				hl = {
					merge_override = {
						texCmd = { "#b14242" },
						texCmdGreek = { "#b14242" },
						texCmdItem = { "#4a8b8b" },
						texPartArgTitle = { "#4a8b8b" },
						texArg = { "#4a8b8b" },
						texRefArg = { "#f38ba8" },
						texMathZone = { "#E49A44" },
						texMathOper = { "#fab387" },
						texMathEnvArgName = { "#4a8b8b" },
						texMathSymbol = { "#b14242" },
						texDelim = { "#f56e6e" },
						texMathSuperSub = { "#f56e6e" },
						texMathDelimMod = { "#f56e6e" },
						texEnvArgName = { "#4a8b8b" },
						texComment = { "#6c7086" },
						texLength = { "#4a8b8b" },
						texSpecialChar = { "#fab387" },
					},
				},
			})

			-- vim.cmd.colorscheme("ashen")
		end,
	},

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
						texCmd = { fg = "#cba6f7" },
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
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
