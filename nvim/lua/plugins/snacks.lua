return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      width = 40,
      sections = function()
        local ascii = require("ascii")
        local header = table.concat(ascii.art.text.neovim.sharp, "\n")
        local function greeting()
          local hour = tonumber(vim.fn.strftime("%H"))
          local day_part

          if hour < 12 then
            day_part = "morning"
          elseif hour < 18 then
            day_part = "afternoon"
          else
            day_part = "evening"
          end

          local username = os.getenv("USER") or os.getenv("USERNAME") or "user"
          return ("Good %s, %s"):format(day_part, username)
        end
        return {
          { padding = 0, align = "center", text = { header, hl = "header" } },
          { padding = 2, align = "center", text = { greeting(), hl = "header" } },
          {
            title = "Builtin Actions",
            indent = 2,
            padding = 1,
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          { title = "Recent Projects", section = "projects", indent = 2, padding = 1 },
          {
            title = "Maintenance Actions",
            indent = 2,
            padding = 2,
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "󱁤 ", key = "m", desc = "Mason", action = ":Mason" },
          },
          { section = "startup" },
        }
      end,
    },

    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = {
      enabled = true,
      filter = function(buf)
        return vim.bo[buf].filetype ~= "tex"
      end,
    },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle
            .option("background", { off = "light", on = "dark", name = "Dark Background" })
            :map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
