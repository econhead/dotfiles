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
  -- The `in_mathzone` function requires the VimTeX plugin
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

----------------Greek Letters-------------------------
return {
  s({ trig = ";a", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\alpha") }),

  s({ trig = ";b", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\beta") }),

  s({ trig = ";g", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\gamma") }),

  s({ trig = ";d", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\delta") }),

  s({ trig = ";e", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\epsilon") }),

  s({ trig = ";z", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\zeta") }),

  s({ trig = ";h", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\eta") }),

  s({ trig = ";t", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\theta") }),

  s({ trig = ";i", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\iota") }),

  s({ trig = ";k", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\kappa") }),

  s({ trig = ";l", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\lambda") }),

  s({ trig = ";m", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\mu") }),

  s({ trig = ";n", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\nu") }),

  s({ trig = ";x", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\xi") }),

  s({ trig = ";o", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\omicron") }),

  s({ trig = ";p", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\pi") }),

  s({ trig = ";r", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\rho") }),

  s({ trig = ";s", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\sigma") }),

  s({ trig = "tau", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\tau") }),

  s({ trig = ";u", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\upsilon") }),

  s({ trig = ";f", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\phi") }),

  s({ trig = ";c", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\chi") }),

  s({ trig = "psi", wordTrig = false, snippetType = "autosnippet" }, { t("\\psi") }),

  s({ trig = ";w", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\omega") }),

  s({ trig = ";A", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Alpha") }),

  s({ trig = ";B", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Beta") }),

  s({ trig = ";G", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Gamma") }),

  s({ trig = ";D", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Delta") }),

  s({ trig = ";E", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Epsilon") }),

  s({ trig = ";Z", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Zeta") }),

  s({ trig = ";H", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Eta") }),

  s({ trig = ";T", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Theta") }),

  s({ trig = ";I", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Iota") }),

  s({ trig = ";K", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Kappa") }),

  s({ trig = ";L", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Lambda") }),

  s({ trig = ";M", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Mu") }),

  s({ trig = ";N", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Nu") }),

  s({ trig = ";X", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Xi") }),

  s({ trig = ";O", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Omicron") }),

  s({ trig = ";P", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Pi") }),

  s({ trig = ";R", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Rho") }),

  s({ trig = ";S", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Sigma") }),

  s({ trig = "Tau", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Tau") }),

  s({ trig = ";U", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Upsilon") }),

  s({ trig = ";F", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Phi") }),

  s({ trig = ";C", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Chi") }),

  s({ trig = "Psi", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Psi") }),

  s({ trig = ";W", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\Omega") }),

  ---------------------Greek Letters \var editon-----------------------

  s({ trig = ":a", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varalpha") }),

  s({ trig = ":b", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varbeta") }),

  s({ trig = ":g", snippetType = "autosnippet", condition = in_mathzone }, { t("\\vargamma") }),

  s({ trig = ":d", snippetType = "autosnippet", condition = in_mathzone }, { t("\\vardelta") }),

  s({ trig = ":e", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varepsilon") }),

  s({ trig = ":z", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varzeta") }),

  s({ trig = ":h", snippetType = "autosnippet", condition = in_mathzone }, { t("\\vareta") }),

  s({ trig = ":t", snippetType = "autosnippet", condition = in_mathzone }, { t("\\vartheta") }),

  s({ trig = ":i", snippetType = "autosnippet", condition = in_mathzone }, { t("\\variota") }),

  s({ trig = ":k", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varkappa") }),

  s({ trig = ":l", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varlambda") }),

  s({ trig = ":m", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varmu") }),

  s({ trig = ":n", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varnu") }),

  s({ trig = ":x", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varxi") }),

  s({ trig = ":o", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varomicron") }),

  s({ trig = ":p", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varpi") }),

  s({ trig = ":r", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varrho") }),

  s({ trig = ":s", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varsigma") }),

  s({ trig = ":u", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varupsilon") }),

  s({ trig = ":f", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varphi") }),

  s({ trig = ":c", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varchi") }),

  s({ trig = ":w", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varomega") }),

  s({ trig = ":A", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varAlpha") }),

  s({ trig = ":B", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varBeta") }),

  s({ trig = ":G", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varGamma") }),

  s({ trig = ":D", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varDelta") }),

  s({ trig = ":E", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varEpsilon") }),

  s({ trig = ":Z", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varZeta") }),

  s({ trig = ":H", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varEta") }),

  s({ trig = ":T", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varTheta") }),

  s({ trig = ":I", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varIota") }),

  s({ trig = ":K", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varKappa") }),

  s({ trig = ":L", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varLambda") }),

  s({ trig = ":M", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varMu") }),

  s({ trig = ":N", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varNu") }),

  s({ trig = ":X", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varXi") }),

  s({ trig = ":O", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varOmicron") }),

  s({ trig = ":P", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varPi") }),

  s({ trig = ":R", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varRho") }),

  s({ trig = ":S", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varSigma") }),

  s({ trig = ":U", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varUpsilon") }),

  s({ trig = ":F", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varPhi") }),

  s({ trig = ":C", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varChi") }),

  s({ trig = ":W", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varOmega") }),

  ---------------------Mathbb and Mathcal letter notations------
  s(
    { trig = "mbb", snippetType = "autosnippet" },
    fmta("\\mathbb{<>} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  -- s({ trig = "aa", snippetType = "autosnippet" }, { t("\\mathbb{A}") }, { condition = in_mathzone }),

  --s({ trig = "bb", snippetType = "autosnippet" }, { t("\\mathbb{B}") }, { condition = in_mathzone }),

  --s({ trig = "cc", snippetType = "autosnippet" }, { t("\\mathbb{C}") }, { condition = in_mathzone }),

  -- s({ trig = "dd", snippetType = "autosnippet" }, { t("\\mathbb{D}") }, { condition = in_mathzone }),

  -- s({ trig = "ee", snippetType = "autosnippet" }, { t("\\mathbb{E}") }, { condition = in_mathzone }),

  --s({ trig = "ff", snippetType = "autosnippet" }, { t("\\mathbb{F}") }, { condition = in_mathzone }),

  -- s({ trig = "gg", snippetType = "autosnippet" }, { t("\\mathbb{G}") }, { condition = in_mathzone }),

  -- s({ trig = "hh", snippetType = "autosnippet" }, { t("\\mathbb{H}") }, { condition = in_mathzone }),

  s({ trig = "ii", snippetType = "autosnippet" }, { t("\\mathbb{I}") }, { condition = in_mathzone }),

  -- s({ trig = "jj", snippetType = "autosnippet" }, { t("\\mathbb{J}") }, { condition = in_mathzone }),

  --s({ trig = "kk", snippetType = "autosnippet" }, { t("\\mathbb{K}") }, { condition = in_mathzone }),

  --s({ trig = "ll", snippetType = "autosnippet" }, { t("\\mathbb{L}") }, { condition = in_mathzone }),

  --s({ trig = "mm", snippetType = "autosnippet" }, { t("\\mathbb{M}") }, { condition = in_mathzone }),

  --s({ trig = "nn", snippetType = "autosnippet" }, { t("\\mathbb{N}") }, { condition = in_mathzone }),

  --s({ trig = "oo", snippetType = "autosnippet" }, { t("\\mathbb{O}") }, { condition = in_mathzone }),

  --s({ trig = "pp", snippetType = "autosnippet" }, { t("\\mathbb{P}") }, { condition = in_mathzone }),

  s({ trig = "qq", snippetType = "autosnippet" }, { t("\\mathbb{Q}") }, { condition = in_mathzone }),

  s({ trig = "rr", snippetType = "autosnippet" }, { t("\\mathbb{R}") }, { condition = in_mathzone }),

  -- s({ trig = "ss", snippetType = "autosnippet" }, { t("\\mathbb{S}") }, { condition = in_mathzone }),

  --s({ trig = "tt", snippetType = "autosnippet" }, { t("\\mathbb{T}") }, { condition = in_mathzone }),

  --s({ trig = "uu", snippetType = "autosnippet" }, { t("\\mathbb{U}") }, { condition = in_mathzone }),

  --s({ trig = "vv", snippetType = "autosnippet" }, { t("\\mathbb{V}") }, { condition = in_mathzone }),

  s({ trig = "ww", snippetType = "autosnippet" }, { t("\\mathbb{W}") }, { condition = in_mathzone }),

  -- s({ trig = "xx", snippetType = "autosnippet" }, { t("\\mathbb{X}") }, { condition = in_mathzone }),

  -- s({ trig = "yy", snippetType = "autosnippet" }, { t("\\mathbb{Y}") }, { condition = in_mathzone }),

  s({ trig = "zz", snippetType = "autosnippet" }, { t("\\mathbb{Z}") }, { condition = in_mathzone }),

  s(
    { trig = "mcal", snippetType = "autosnippet" },
    fmta("\\mathcal{<>} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),

  s({ trig = "AA", snippetType = "autosnippet" }, { t("\\mathcal{A}") }, { condition = in_mathzone }),

  s({ trig = "BB", snippetType = "autosnippet" }, { t("\\mathcal{B}") }, { condition = in_mathzone }),

  s({ trig = "CC", snippetType = "autosnippet" }, { t("\\mathcal{C}") }, { condition = in_mathzone }),

  s({ trig = "DD", snippetType = "autosnippet" }, { t("\\mathcal{D}") }, { condition = in_mathzone }),

  s({ trig = "EE", snippetType = "autosnippet" }, { t("\\mathcal{E}") }, { condition = in_mathzone }),

  s({ trig = "FF", snippetType = "autosnippet" }, { t("\\mathcal{F}") }, { condition = in_mathzone }),

  s({ trig = "GG", snippetType = "autosnippet" }, { t("\\mathcal{G}") }, { condition = in_mathzone }),

  s({ trig = "HH", snippetType = "autosnippet" }, { t("\\mathcal{H}") }, { condition = in_mathzone }),

  s({ trig = "II", snippetType = "autosnippet" }, { t("\\mathcal{I}") }, { condition = in_mathzone }),

  s({ trig = "JJ", snippetType = "autosnippet" }, { t("\\mathcal{J}") }, { condition = in_mathzone }),

  s({ trig = "KK", snippetType = "autosnippet" }, { t("\\mathcal{K}") }, { condition = in_mathzone }),

  s({ trig = "LL", snippetType = "autosnippet" }, { t("\\mathcal{L}") }, { condition = in_mathzone }),

  s({ trig = "MM", snippetType = "autosnippet" }, { t("\\mathcal{M}") }, { condition = in_mathzone }),

  s({ trig = "NN", snippetType = "autosnippet" }, { t("\\mathcal{N}") }, { condition = in_mathzone }),

  s({ trig = "OO", snippetType = "autosnippet" }, { t("\\mathcal{O}") }, { condition = in_mathzone }),

  s({ trig = "PP", snippetType = "autosnippet" }, { t("\\mathcal{P}") }, { condition = in_mathzone }),

  s({ trig = "QQ", snippetType = "autosnippet" }, { t("\\mathcal{Q}") }, { condition = in_mathzone }),

  s({ trig = "mRR", snippetType = "autosnippet" }, { t("\\mathcal{R}") }, { condition = in_mathzone }),

  s({ trig = "SS", snippetType = "autosnippet" }, { t("\\mathcal{S}") }, { condition = in_mathzone }),

  s({ trig = "TT", snippetType = "autosnippet" }, { t("\\mathcal{T}") }, { condition = in_mathzone }),

  s({ trig = "UU", snippetType = "autosnippet" }, { t("\\mathcal{U}") }, { condition = in_mathzone }),

  s({ trig = "VV", snippetType = "autosnippet" }, { t("\\mathcal{V}") }, { condition = in_mathzone }),

  s({ trig = "WW", snippetType = "autosnippet" }, { t("\\mathcal{W}") }, { condition = in_mathzone }),

  s({ trig = "XX", snippetType = "autosnippet" }, { t("\\mathcal{X}") }, { condition = in_mathzone }),

  s({ trig = "YY", snippetType = "autosnippet" }, { t("\\mathcal{Y}") }, { condition = in_mathzone }),

  s({ trig = "ZZ", snippetType = "autosnippet" }, { t("\\mathcal{Z}") }, { condition = in_mathzone }),
}
