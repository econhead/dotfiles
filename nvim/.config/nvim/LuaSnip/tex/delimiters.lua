local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
  return tex_utils.in_env("equation")
end
tex_utils.in_itemize = function() -- itemize environment detection
  return tex_utils.in_env("itemize")
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
  return tex_utils.in_env("tikzpicture")
end

return {

  -- lr( -> \left( \right)
  s(
    { trig = "lrp", snippetType = "autosnippet" },
    fmta("\\left( <> \\right) <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  -- lr| -> \left| \right|
  s(
    { trig = "lr|", snippetType = "autosnippet" },
    fmta("\\left| <> \\right| <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  -- lr{ -> \left\{ \right\}
  s(
    { trig = "lr{", snippetType = "autosnippet" },
    fmta("\\left\\{ <> \\right\\} <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  -- lrb -> \left\{ \right\}
  s(
    { trig = "lrb", snippetType = "autosnippet" },
    fmta("\\left\\{ <> \\right\\} <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  -- lr[ -> \left[ \right]
  s(
    { trig = "lr[", snippetType = "autosnippet" },
    fmta("\\left[ <> \\right] <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  s(
    { trig = "lra", snippetType = "autosnippet" },
    fmt("\\left< {} \\right> {}", {
      d(1, get_visual),
      i(0),
    })
  ),
}
