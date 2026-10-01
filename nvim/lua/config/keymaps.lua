vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
map("n", "<leader>s", "<cmd>source<CR>", { desc = "source init.lua" })
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

-- ============================================================================
-- Snacks
-- ============================================================================
-- Top Pickers & Explorer

map("n", "<leader><space>", function()
  Snacks.picker.smart()
end, { desc = "Smart Find Files" })

map("n", "<leader>,", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

map("n", "<leader>:", function()
  Snacks.picker.command_history()
end, { desc = "Command History" })

map("n", "<leader>n", function()
  Snacks.notifier.show_history()
end, { desc = "Notification History" })

map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "File Explorer" })


-- Find

map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<leader>fc", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files" })

map("n", "<leader>fg", function()
  Snacks.picker.git_files()
end, { desc = "Find Git Files" })

map("n", "<leader>fp", function()
  Snacks.picker.projects()
end, { desc = "Projects" })

map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent" })


-- Git

map("n", "<leader>gb", function()
  Snacks.picker.git_branches()
end, { desc = "Git Branches" })

map("n", "<leader>gl", function()
  Snacks.picker.git_log()
end, { desc = "Git Log" })

map("n", "<leader>gL", function()
  Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })

map("n", "<leader>gs", function()
  Snacks.picker.git_status()
end, { desc = "Git Status" })

map("n", "<leader>gS", function()
  Snacks.picker.git_stash()
end, { desc = "Git Stash" })

map("n", "<leader>gd", function()
  Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })

map("n", "<leader>gf", function()
  Snacks.picker.git_log_file()
end, { desc = "Git Log File" })


-- GitHub

map("n", "<leader>gi", function()
  Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })

map("n", "<leader>gI", function()
  Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })

map("n", "<leader>gp", function()
  Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })

map("n", "<leader>gP", function()
  Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })


-- Grep / Search

map("n", "<leader>sb", function()
  Snacks.picker.lines()
end, { desc = "Buffer Lines" })

map("n", "<leader>sB", function()
  Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })

map("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

map({ "n", "x" }, "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "Visual Selection or Word" })

map("n", '<leader>s"', function()
  Snacks.picker.registers()
end, { desc = "Registers" })

map("n", "<leader>s/", function()
  Snacks.picker.search_history()
end, { desc = "Search History" })

map("n", "<leader>sa", function()
  Snacks.picker.autocmds()
end, { desc = "Autocmds" })

map("n", "<leader>sc", function()
  Snacks.picker.command_history()
end, { desc = "Command History" })

map("n", "<leader>sC", function()
  Snacks.picker.commands()
end, { desc = "Commands" })

map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })

map("n", "<leader>sD", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })

map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "Help Pages" })

map("n", "<leader>sH", function()
  Snacks.picker.highlights()
end, { desc = "Highlights" })

map("n", "<leader>si", function()
  Snacks.picker.icons()
end, { desc = "Icons" })

map("n", "<leader>sj", function()
  Snacks.picker.jumps()
end, { desc = "Jumps" })

map("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "Keymaps" })

map("n", "<leader>sl", function()
  Snacks.picker.loclist()
end, { desc = "Location List" })

map("n", "<leader>sm", function()
  Snacks.picker.marks()
end, { desc = "Marks" })

map("n", "<leader>sM", function()
  Snacks.picker.man()
end, { desc = "Man Pages" })

map("n", "<leader>sp", function()
  Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })

map("n", "<leader>sq", function()
  Snacks.picker.qflist()
end, { desc = "Quickfix List" })

map("n", "<leader>sR", function()
  Snacks.picker.resume()
end, { desc = "Resume" })

map("n", "<leader>su", function()
  Snacks.picker.undo()
end, { desc = "Undo History" })

map("n", "<leader>uC", function()
  Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })


-- LSP

map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

map("n", "gD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })

map("n", "gr", function()
  Snacks.picker.lsp_references()
end, {
  desc = "References",
  nowait = true,
})

map("n", "gI", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

map("n", "gy", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Goto Type Definition" })

map("n", "gai", function()
  Snacks.picker.lsp_incoming_calls()
end, { desc = "Calls Incoming" })

map("n", "gao", function()
  Snacks.picker.lsp_outgoing_calls()
end, { desc = "Calls Outgoing" })

map("n", "<leader>ss", function()
  Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })

map("n", "<leader>sS", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })


-- Other Snacks Features

map("n", "<leader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })

map("n", "<leader>Z", function()
  Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })

map("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

map("n", "<leader>S", function()
  Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>cR", function()
  Snacks.rename.rename_file()
end, { desc = "Rename File" })

map({ "n", "v" }, "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse" })

map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

map("n", "<leader>un", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

map("n", "<C-/>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })

map("n", "<C-_>", function()
  Snacks.terminal()
end, { desc = "which_key_ignore" })

map({ "n", "t" }, "]]", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })

map({ "n", "t" }, "[[", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

map("n", "<leader>N", function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, { desc = "Neovim News" })
