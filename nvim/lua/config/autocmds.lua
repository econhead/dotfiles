local group = vim.api.nvim_create_augroup("notes_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "tex", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = false
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

-- Focus kitty window on inverse search

-- vim.api.nvim_create_autocmd("User", {
--   group = group,
--   pattern = "VimtexEventViewReverse",
--   callback = function()
--     vim.fn.jobstart({
--       "hyprctl",
--       "dispatch",
--       [[hl.dsp.focus({ window = "class:^kitty$" })]],
--     })
--   end,
--   desc = "Focus kitty after VimTeX reverse search",
-- })


-- focus sioyek on forward search like zathura with xdotool

-- local function regex_escape(str)
--   return vim.fn.escape(str, "\\.^$|?*+(){}[]")
-- end
--
-- local function get_vimtex_pdf_name()
--   local ok, pdf = pcall(vim.api.nvim_eval, "b:vimtex.viewer.out()")
--
--   if not ok or type(pdf) ~= "string" or pdf == "" then
--     return nil
--   end
--
--   return vim.fn.fnamemodify(pdf, ":t")
-- end
--
-- local function focus_sioyek()
--   local pdf_name = get_vimtex_pdf_name()
--
--   if not pdf_name then
--     vim.notify(
--       "Could not determine VimTeX PDF output",
--       vim.log.levels.WARN
--     )
--     return
--   end
--
--   local escaped_title = regex_escape(pdf_name)
--
--   vim.defer_fn(function()
--     vim.fn.jobstart({
--       "hyprctl",
--       "dispatch",
--       string.format(
--         [=[hl.dsp.focus({ window = [[title:^%s$]] })]=],
--         escaped_title
--       ),
--     })
--   end, 100)
-- end
--
-- vim.api.nvim_create_autocmd("User", {
--   group = group,
--   pattern = "VimtexEventInitPost",
--   callback = function()
--     vim.keymap.set("n", "<localleader>lv", function()
--       vim.cmd("VimtexView")
--       focus_sioyek()
--     end, {
--       buffer = true,
--       desc = "VimTeX view and focus matching Sioyek window",
--     })
--   end,
-- })
