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
						texMathZone = { "#f56e6e" },
						texMathOper = { "#fab387" },
						texMathEnvArgName = { "#4a8b8b" },
						texMathSymbol = { "#b14242" },
						texDelim = { "#E49A44" },
						texMathSuperSub = { "#E49A44" },
						texMathDelimMod = { "#E49A44" },
						texEnvArgName = { "#4a8b8b" },
						texComment = { "#6c7086" },
						texLength = { "#4a8b8b" },
						texSpecialChar = { "#fab387" },
					},
				},
			})

			vim.cmd.colorscheme("ashen")
		end,
	},
}
