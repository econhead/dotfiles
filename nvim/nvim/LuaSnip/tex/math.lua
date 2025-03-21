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

return {

  ---------------------Auto Hat,Bar,Overline and vector notation---------------------------

  s(
    { trig = "hat", snippetType = "autosnippet" },
    fmta("\\hat{<>}<>", {
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  s({
    trig = "([a-zA-Z])hat",
    regTrig = true, -- Enable regex triggering
    wordTrig = false, -- Allow triggering within words
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return "\\hat{" .. snip.captures[1] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  s(
    { trig = "bar", snippetType = "autosnippet" },
    fmta("\\bar{<>}<>", {
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  s({
    trig = "([a-zA-Z])bar",
    regTrig = true, -- Enable regex triggering
    wordTrig = false, -- Allow triggering within words
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return "\\bar{" .. snip.captures[1] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  s(
    { trig = "over", snippetType = "autosnippet" },
    fmta("\\overline{<>}<>", {
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  s({
    trig = "([a-zA-Z])over",
    regTrig = true, -- Enable regex triggering
    wordTrig = false, -- Allow triggering within words
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return "\\overline{" .. snip.captures[1] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  s({
    trig = "(\\?%w+)([.,])",
    regTrig = true, -- Enable regex triggering
    wordTrig = false, -- triggering within words
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return "\\vec{" .. snip.captures[1] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  -----------------Autosubscript-----------------------------------------------
  s({
    trig = "([%a%)%]%}])(%d+)", -- Match letters followed by digits
    regTrig = true, -- Enables regex matching
    wordTrig = false, -- Allows it to trigger inside words
    snippetType = "autosnippet", -- Autoexpansion restricts subscipt to only one digit
  }, {
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  s({
    trig = "([A-Za-z]+)(%a+)", -- Match letters followed by letters
    regTrig = true, -- Enables regex matching
    wordTrig = false, -- Allows it to trigger inside words
  }, {
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  s(
    { trig = "_", snippetType = "autosnippet", wordTrig = false },
    fmta("_{<>} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),

  s({ trig = "sr", snippetType = "autosnippet" }, fmta("^2", {}), { condition = in_mathzone }),

  s({ trig = "cb", snippetType = "autosnippet" }, fmta("^3", {}), { condition = in_mathzone }),

  ----------------Autosuperscript-------------------------------------------------
  s({
    trig = "(%d+)([A-Za-z]+)", -- Match digit(s) followed by letter(s)
    regTrig = true,
    wordTrig = false, -- Auto expansion restricts superscript to only one digit
  }, {
    f(function(_, snip)
      return snip.captures[2] .. "^{" .. snip.captures[1] .. "}"
    end),
  }, {
    condition = in_mathzone,
  }),

  s(
    { trig = "rd", snippetType = "autosnippet", wordTrig = false },
    fmta("^{<>} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),

  ----------------------------Wrap into inline and Display math mode--------------------------

  s(
    { trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\(<>\\)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  s(
    { trig = "([^%a])dd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\[<>\\]", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  s(
    { trig = "([^%a])ee", regTrig = true, wordTrig = false },
    fmta("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  ----------------------------------------------------------------------------
  s({ trig = "...", snippetType = "autosnippet" }, { t("\\ldots") }, { condition = in_mathzone }),

  s({ trig = ",,,", snippetType = "autosnippet" }, { t("\\cdots") }, { condition = in_mathzone }),

  s({ trig = "**", snippetType = "autosnippet" }, { t("\\cdot") }, { condition = in_mathzone }),

  s({ trig = "xx", snippetType = "autosnippet", priority = 1000 }, { t("\\times") }, { condition = in_mathzone }),

  -------------------Logic, Set Theroy and other common Operators----------------------------------
  s({ trig = "~", snippetType = "autosnippet" }, { t("\\sim") }, { condition = in_mathzone }),

  s({ trig = ".~", snippetType = "autosnippet" }, { t("\\mathrel{\\dot\\sim}") }, { condition = in_mathzone }),

  s({ trig = ">>", snippetType = "autosnippet" }, { t("\\gg") }, { condition = in_mathzone }),

  s({ trig = "<<", snippetType = "autosnippet" }, { t("\\ll") }, { condition = in_mathzone }),

  s({ trig = "set", snippetType = "autosnippet" }, fmta("\\{<>\\} <>", { i(1), i(0) }), { condition = in_mathzone }),

  s({ trig = "\\\\\\", snippetType = "autosnippet" }, { t("\\setminus") }, { condition = in_mathzone }),

  s({ trig = "fll", snippetType = "autosnippet" }, { t("\\forall") }, { condition = in_mathzone }),

  s({ trig = "ext", snippetType = "autosnippet" }, { t("\\exists") }, { condition = in_mathzone }),

  s({ trig = "next", snippetType = "autosnippet" }, { t("\\nexists") }, { condition = in_mathzone }),

  s({ trig = "inn", snippetType = "autosnippet" }, { t("\\in") }, { condition = in_mathzone }),

  s({ trig = "notin", snippetType = "autosnippet" }, { t("\\notin") }, { condition = in_mathzone }),

  s({ trig = "comp", snippetType = "autosnippet", wordTrig = false }, { t("^{c}") }, { condition = in_mathzone }),

  s({ trig = "invs", snippetType = "autosnippet", wordTrig = false }, { t("^{-1}") }, { condition = in_mathzone }),

  s({ trig = "subs", snippetType = "autosnippet" }, { t("\\subset") }, { condition = in_mathzone }),

  s({ trig = "subeq", snippetType = "autosnippet" }, { t("\\subseteq") }, { condition = in_mathzone }),

  s({ trig = "sups", snippetType = "autosnippet" }, { t("\\supset") }, { condition = in_mathzone }),

  s({ trig = "||", snippetType = "autosnippet" }, { t("\\mid") }, { condition = in_mathzone }),

  s({ trig = "land", snippetType = "autosnippet" }, { t("\\land") }, { condition = in_mathzone }),

  s({ trig = "lor", snippetType = "autosnippet" }, { t("\\lor") }, { condition = in_mathzone }),

  s({ trig = "ni", snippetType = "autosnippet" }, { t("\\ni") }, { condition = in_mathzone }),

  s({ trig = "the", snippetType = "autosnippet" }, { t("\\therefore") }, { condition = in_mathzone }),

  s({ trig = "bec", snippetType = "autosnippet" }, { t("\\because") }, { condition = in_mathzone }),

  s({ trig = "map", snippetType = "autosnippet" }, { t("\\mapsto") }, { condition = in_mathzone }),

  s({ trig = "to", snippetType = "autosnippet" }, { t("\\to") }, { condition = in_mathzone }),

  s({ trig = "get", snippetType = "autosnippet" }, { t("\\gets") }, { condition = in_mathzone }),

  s({ trig = "<=>" }, { t("\\Leftrightarrow") }, { condition = in_mathzone }),

  s({ trig = "<->" }, { t("\\leftrightarrow") }, { condition = in_mathzone }),

  s({ trig = "emp", snippetType = "autosnippet" }, { t("\\emptyset") }, { condition = in_mathzone }),

  s({ trig = "varn", snippetType = "autosnippet" }, { t("\\varnothing") }, { condition = in_mathzone }),

  s({ trig = "=>" }, { t("\\implies") }, { condition = in_mathzone }),

  s({ trig = "<=" }, { t("\\impliedby") }, { condition = in_mathzone }),

  s({ trig = "iff", snippetType = "autosnippet" }, { t("\\iff") }, { condition = in_mathzone }),

  s({ trig = "notni", snippetType = "autosnippet" }, { t("\\not\\ni") }, { condition = in_mathzone }),

  s({ trig = "neg", snippetType = "autosnippet" }, { t("\\neg") }, { condition = in_mathzone }),

  s({ trig = "uu", snippetType = "autosnippet" }, { t("\\cup") }, { condition = in_mathzone }),

  s({ trig = "Nn", snippetType = "autosnippet" }, { t("\\cap") }, { condition = in_mathzone }),

  -----------------------------------common math functions---------------

  s({ trig = "sin", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\sin") }),

  s({ trig = "cos", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\cos") }),

  s({ trig = "tan", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\tan") }),

  s({ trig = "asin", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\arcsin") }),

  s({ trig = "acos", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\arccos") }),

  s({ trig = "atan", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\arctan") }),

  s({ trig = "hsin", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\sinh") }),

  s({ trig = "hcos", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\cosh") }),

  s({ trig = "htan", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\tanh") }),

  s({ trig = "csc", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\csc") }),

  s({ trig = "sec", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\sec") }),

  s({ trig = "cot", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\cot") }),

  s({ trig = "log", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\log") }),

  s({ trig = "ln", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\ln") }),

  s({ trig = "exp", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\exp") }),

  -- s({ trig = "lim", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\lim") }),

  s({ trig = ";max", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\max") }),

  s({ trig = ";min", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\min") }),

  s({ trig = "sup", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\sup") }),

  s({ trig = "inf", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\inf") }),

  s({ trig = "arg", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\arg") }),

  s({ trig = "det", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\det") }),

  s({ trig = "dim", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\dim") }),

  s({ trig = "gcd", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\gcd") }),

  s({ trig = "lcm", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\lcm") }),

  s({ trig = "mod", wordTrig = false, snippetType = "autosnippet", condition = in_mathzone }, { t("\\mod") }),

  s({ trig = "geq", wordTrig = false, snippetType = "autosnippet" }, { t("\\geq") }, { condition = in_mathzone }),

  s({ trig = "leq", wordTrig = false, snippetType = "autosnippet" }, { t("\\leq") }, { condition = in_mathzone }),

  -------------------------------------fractions---------------------------------

  s({
    trig = "ff",
    snippetType = "autosnippet",
  }, fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = in_mathzone }),

  s(
    {
      trig = "(\\?[%w\\]+[%^_%d{}]*)/",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    {
      t("\\frac{"),
      f(function(_, snip)
        return snip.captures[1] or ""
      end), -- Extracts the numerator
      t("}{"),
      i(1),
      t("}"),
      i(0), -- Cursor at the end
    },
    { condition = in_mathzone } -- Ensures expansion only in math mode
  ),

  s(
    {
      trig = "^.+%)%/", -- Match any expression ending with `)/`
      regTrig = true,
      wordTrig = false,
      --snippetType = "autosnippet",
    },
    {
      f(function(_, snip)
        local stripped = snip.trigger:sub(1, -2) -- Remove trailing `/`
        local depth, idx = 0, #stripped -- Use `idx` instead of `i`

        while idx > 0 do
          local char = stripped:sub(idx, idx)
          if char == ")" then
            depth = depth + 1
          end
          if char == "(" then
            depth = depth - 1
          end
          if depth == 0 then
            break
          end
          idx = idx - 1
        end

        if idx > 0 then
          -- Extract correctly by removing both enclosing parentheses
          local numerator = stripped:sub(idx + 1, -2) -- Remove the last `)`
          local prefix = stripped:sub(1, idx - 1) -- Keep anything before `(`

          return prefix .. "\\frac{" .. numerator .. "}"
        else
          return stripped -- Fallback in case of a pattern error
        end
      end),
      t("{"),
      i(1),
      t("}"), -- Insert empty denominator for manual input
      i(0), -- Final cursor position
    },
    { condition = in_mathzone } -- Ensures it only expands inside math mode
  ),

  s(
    { trig = "fv", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}", {
      d(1, get_visual),
      i(2),
    }),
    {
      condition = in_mathzone,
    }
  ),

  ------------------------------Functions------------------------------------------

  s(
    { trig = "bfunc", snippetType = "autosnippet" },
    fmta(
      [[\begin{align*}
        <> : <> &\longrightarrow <> \\\\
        <> &\longmapsto <>(<>) = <> 
        \end{align*}<>
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        rep(1),
        rep(4),
        i(5),
        i(0),
      }
    )
  ),

  s(
    { trig = "cup", snippetType = "autosnippet" },
    fmta("\\bigcup_{{<> \\in <> }} <>", {
      i(1, "i"),
      i(2, "I"),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "cap", snippetType = "autosnippet" },
    fmta("\\bigcap_{{<> \\in <> }} <>", {
      i(1, "i"),
      i(2, "I"),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  ------------------------------------Vectors-------------------------------------

  s(
    { trig = "cvec", dscr = "Column Vector", snippetType = "autosnippet" },
    fmta(
      [[
\begin{pmatrix} <>_<> \\
\vdots \\
<>_<> \end{pmatrix}
      ]],
      {
        i(1, "x"), -- First variable (e.g., x)
        i(2, "1"), -- First subscript (default 1)
        rep(1), -- Repeats the first variable
        i(3, "n"), -- Last subscript (default n)
      }
    ),
    { condition = in_mathzone } -- Ensures it works only in math mode
  ),

  s(
    { trig = "rvec", dscr = "Row Vector", snippetType = "autosnippet" },
    fmta(
      [[
\begin{pmatrix} <>_<> & \cdots & <>_<> \end{pmatrix}
      ]],
      {
        i(1, "x"), -- First variable (default "x")
        i(2, "1"), -- First subscript (default "1")
        rep(1), -- Repeats the first variable
        i(3, "n"), -- Last subscript (default "n")
      }
    ),
    { condition = in_mathzone } -- Ensures it works only in math mode
  ),

  -------------------------------Integrals------------------------------------------

  s(
    { trig = "dint", dscr = "Definite Integral", snippetType = "autosnippet" },
    fmta(
      [[
\int_{<>}^{<>} <> <>
      ]],
      {
        i(1, "-\\infty"), -- Default lower limit (-∞)
        i(2, "\\infty"), -- Default upper limit (∞)
        d(3, get_visual), -- Visual selection support
        i(0), -- Final placeholder
      }
    ),
    { condition = in_mathzone } -- Expands only in math mode
  ),

  s({ trig = "1int", snippetType = "autosnippet", condition = in_mathzone }, t("\\int ")),

  s({ trig = "2int", snippetType = "autosnippet", condition = in_mathzone }, t("\\iint ")),

  s({ trig = "3int", snippetType = "autosnippet", condition = in_mathzone }, t("\\iiint ")),

  s({ trig = "0int", snippetType = "autosnippet", condition = in_mathzone }, t("\\oint ")),

  s(
    { trig = "cint", snippetType = "autosnippet", condition = in_mathzone },
    fmta("\\int_{<>}^{<>} <>", { i(1, "0"), i(2, "\\infty"), i(0) })
  ),

  s({ trig = "inti", snippetType = "autosnippet", condition = in_mathzone }, t("\\int_{-\\infty}^{\\infty} ")),

  ------------------------------------Summation----------------------------------------------
  s(
    { trig = "sum", snippetType = "autosnippet" },
    fmta("\\sum_{n=<>}^{<>} <>", { i(1, "1"), i(2, "\\infty"), i(3, "function") }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "2sum", snippetType = "autosnippet" },
    fmta(
      "\\sum_{i=<>}^{<>}\\sum_{j=<>}^{<>} <>",
      { i(1, "1"), i(2, "\\infty"), i(3, "1"), i(4, "\\infty"), i(5, "function") }
    ),
    { condition = in_mathzone }
  ),

  -----------------------------------Limits----------------------------------------------------------
  s(
    { trig = "lim", snippetType = "autosnippet" },
    fmta("\\lim_{<> \\to <>} <> ", { i(1, "n"), i(2, "\\infty"), i(0) }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "limsup", snippetType = "autosnippet" },
    fmta("\\limsup_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "liminf", snippetType = "autosnippet" },
    fmta("\\liminf_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }),
    { condition = in_mathzone }
  ),

  ------------------------------------Partial derivative--------------------------------------------------
  s(
    { trig = "part", snippetType = "autosnippet" },
    fmta("\\frac{\\partial <>}{\\partial <>} <>", { i(1, "U"), i(2, "x"), i(0) }),
    { condition = in_mathzone }
  ),

  ----------------------------------Infinity symbol-------------------------------------------
  s({ trig = "oo", snippetType = "autosnippet" }, fmta("\\infty", {}), { condition = in_mathzone }),

  -----------------------------------Roots------------------------------------------
  s(
    { trig = "sq", snippetType = "autosnippet" },
    fmta("\\sqrt{<>} <>", { i(1, "x"), i(0) }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "cb", snippetType = "autosnippet" },
    fmta("\\cbrt{<>} <>", { i(1, "x"), i(0) }),
    { condition = in_mathzone }
  ),

  -- Square root with visual selection
  s(
    { trig = "sq", snippetType = "autosnippet" },
    fmta("\\sqrt{<>} <>", {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  ----------------------------------Product--------------------------------------------------
  s(
    { trig = "prod", snippetType = "autosnippet" },
    fmta("\\prod_{<> = <>}^{<>} <>", {
      i(1, "n"),
      i(2, "1"),
      i(3, "\\infty"),
      d(4, get_visual),
    }),
    { condition = in_mathzone }
  ),

  -- Equals sign for alignment
  s({ trig = "==", snippetType = "autosnippet", condition = in_mathzone }, fmta("&= <> \\\\", { i(1) })),

  -- Ceil function
  s(
    { trig = "ceil", snippetType = "autosnippet", condition = in_mathzone },
    fmta("\\left\\lceil <> \\right\\rceil <>", { i(1), i(0) })
  ),

  -- Floor function
  s(
    { trig = "floor", snippetType = "autosnippet", condition = in_mathzone },
    fmta("\\left\\lfloor <> \\right\\rfloor <>", { i(1), i(0) })
  ),

  -- Parenthesis matrix
  s(
    { trig = "pmat", snippetType = "autosnippet", condition = in_mathzone },
    fmta("\\begin{pmatrix} <> \\end{pmatrix} <>", { i(1), i(0) })
  ),

  -- Bracket matrix
  s(
    { trig = "bmat", snippetType = "autosnippet", condition = in_mathzone },
    fmta("\\begin{bmatrix} <> \\end{bmatrix} <>", { i(1), i(0) })
  ),

  s({ trig = "qq", snippetType = "autosnippet", condition = in_mathzone }, { t("\\quad") }),

  -------------------------------------Optimization Problems---------------------------------------------
  s({ trig = "R+", snippetType = "autosnippet" }, { t("\\mathbb{R}_{+}") }, { condition = in_mathzone }),

  s(
    { trig = "RR", snippetType = "autosnippet" },
    fmta("\\mathbb{R}^{<>}_{+} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "Rr", snippetType = "autosnippet" },
    fmta("\\mathbb{R}^{<>} <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),

  --------------------------Maximization Problem with 2 constraints------------------------
  s(
    { trig = "2maxp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \max_{(<>) <>} & \quad <> \\
            s.t. & \quad <> \\
                 & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3), i(4), i(5) }
    )
  ),

  ------------------Minimization Problem with 2 constraints---------------------------------
  s(
    { trig = "2minp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \min_{(<>) <>} & \quad <> \\
            s.t. & \quad <> \\
                 & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3), i(4), i(5) }
    )
  ),

  ------------------Maximization and Minimization Problems with one constraint-------------------------------
  s(
    { trig = "1maxp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \max_{(<>) <>} & \quad <> \\
            s.t. & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3), i(4) }
    )
  ),

  s(
    { trig = "1minp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \min_{(<>) <>} & \quad <> \\
            s.t. & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3), i(4) }
    )
  ),

  ------------------Maximization and Minimization in R^n_+ with one constraint--------------------------------------
  s(
    { trig = "nmaxp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \max_{(<>,<>,\ldots,<>) \in \mathbb{R}^{n}_{+}}  & \quad <> \\
            s.t. & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3), i(4), i(5) }
    )
  ),

  s(
    { trig = "nmixp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \min_{(<>,<>,\ldots,<>) \in \mathbb{R}^{n}_{+}}  & \quad <> \\
            s.t. & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3), i(4), i(5) }
    )
  ),

  -----------------Unconstrained Maximization Minimization Problems------------------------------
  s(
    { trig = "maxp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \max_{(<>) <>}  & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3) }
    )
  ),

  s(
    { trig = "minp", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{align*}
            \min_{(<>) <>}  & \quad <>
        \end{align*}
        ]],
      { i(1), i(2), i(3) }
    )
  ),
}
