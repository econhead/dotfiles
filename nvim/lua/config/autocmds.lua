local group = vim.api.nvim_create_augroup("notes_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "tex", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "en_gb" }
  end,
  desc = "Use prose-friendly settings for notes",
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  group = group,
  pattern = "*.pdf",
  callback = function()
    local pdf_path = vim.fn.expand("<afile>:p")
    vim.fn.jobstart({ "sioyek", pdf_path }, { detach = true })
    vim.cmd("silent! bwipeout")
  end,
  desc = "Open PDFs in Sioyek",
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "VimtexEventViewReverse",
  callback = function()
    vim.fn.system({ "open", "-a", "WezTerm" })
    vim.cmd("redraw!")
  end,
  desc = "Focus WezTerm after VimTeX reverse search",
})
