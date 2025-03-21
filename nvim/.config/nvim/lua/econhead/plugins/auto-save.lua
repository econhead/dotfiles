return {
  "Pocco81/auto-save.nvim",
  event = "TextChanged", -- Auto-load when leaving insert mode
  config = function()
    require("auto-save").setup({
      enabled = true,
      ASToggle = true, -- Enable auto-save by default
      execution_message = {
        message = function()
          return "AutoSaved!"
        end,
        dim = 0.18,
        cleaning_interval = 1000,
      },
      trigger_events = { "InsertLeave", "TextChanged" }, -- Auto-save on these events
      condition = function(buf)
        local fn = vim.fn
        return fn.getbufvar(buf, "&modifiable") == 1 and fn.getbufvar(buf, "&buftype") == ""
      end,
      write_all_buffers = false,
    })

    vim.api.nvim_set_keymap("n", "<leader>as", ":ASToggle<CR>", {})
  end,
}
