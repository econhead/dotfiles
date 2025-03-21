local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to evaluate the math expression using wolframscript
local eval_math = function(args)
  local expr = args[1][1] -- Get the captured expression
  local cmd = string.format('wolframscript -code "ToString[%s, TeXForm]"', expr)
  local handle = io.popen(cmd) -- Execute the command
  local result = handle:read("*a") -- Read the output
  handle:close()
  print("eval_math called with:", args[1][1])
  return result:gsub("%s+", "") -- Remove any extra whitespace
end

-- Snippet 1: Simple math block
ls.add_snippets("all", {
  s({ trig = "math", wordTrig = true, desc = "Mathematica block" }, { t("math "), i(1), t(" math"), i(0) }),
})

-- Snippet 2: Evaluate Mathematica expression
ls.add_snippets("all", {
  s(
    { trig = "mth", regTrig = true, wordTrig = false, desc = "Evaluate Mathematica expression" },
    f(function(args)
      local expr = args[1][1]
      print("Snippet 2 triggered with expression:", expr) -- Debug print
      return eval_math(args)
    end, { 1 }) -- Pass the captured group to the function
  ),
})
