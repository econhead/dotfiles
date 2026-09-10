vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write buffer" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
map("n", "<leader>vb", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>vs", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>vv", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>vx", "<cmd>close<CR>", { desc = "Close current split" })

map("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Fix previous spelling mistake" })

map("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "Toggle Transparency" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>")

vim.keymap.set("i", "<C-f>", function()
	local root = vim.b.vimtex and vim.b.vimtex.root

	if not root then
		vim.notify("VimTeX root not found", vim.log.levels.WARN)
		return
	end

	local line = vim.fn.getline(".")
	local figures_dir = root .. "/figures/"
	local lnum = vim.api.nvim_win_get_cursor(0)[1]

	vim.cmd.stopinsert()

	local output = vim.fn.systemlist({
		"inkscape-figures",
		"create",
		line,
		figures_dir,
	})

	if vim.v.shell_error ~= 0 then
		vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR)
		return
	end

	vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, output)
	vim.cmd.write()
end, {
	desc = "Create Inkscape figure from current line",
})

vim.keymap.set("n", "<C-f>", function()
	local root = vim.b.vimtex and vim.b.vimtex.root

	if not root then
		vim.notify("VimTeX root not found", vim.log.levels.WARN)
		return
	end

	local figures_dir = root .. "/figures/"

	vim.fn.jobstart({ "inkscape-figures", "edit", figures_dir }, {
		detach = true,
	})

	vim.cmd.redraw()
end, {
	desc = "Edit Inkscape figures",
})
