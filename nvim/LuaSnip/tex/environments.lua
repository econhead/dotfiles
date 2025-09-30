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
  -------------------------------Document Preamble Templates--------------
  s(
    { trig = "tempart2" },
    fmta(
      [[
    \documentclass[12pt,a4paper]{article}
    \usepackage{import}
    \usepackage{pdfpages}
    \usepackage{transparent}
    \usepackage{xcolor}
    \newcommand{\incfig}[2][1]{%
    \def\svgwidth{#1\columnwidth}
    \import{./figures/}{#2.pdf_tex}}
    \pdfsuppresswarningpagegroup=1
    \usepackage[utf8]{inputenc}
    \usepackage[T1]{fontenc}
    \usepackage{parskip}
    \usepackage{amsmath, amssymb, graphicx}
    \usepackage{tcolorbox}
    \usepackage{fancyhdr}
    \setlength{\headheight}{15.6pt}
    \pagestyle{fancyplain}
    \fancyhead[L]{Laxman Singh}
    \fancyhead[R]{<>}
    \usepackage{float}
    \floatstyle{boxed}
    \restylefloat{figure}
    \graphicspath{{<>}}
    \author{Laxman Singh}
    \date{\today}
    \title{<>}

    \begin{document}
     <>
    \end{document}
 ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s(
    { trig = "tempart1" },
    fmta(
      [[
    \documentclass[12pt,a4paper]{article}
    \input{<>}
    \begin{document}
    <>
    \end{document}
 ]],
      {
        i(1, "../preamble.tex"),
        i(2),
      }
    )
  ),

  s({ trig = "pac", snippetType = "autosnippet" }, fmta("\\usepackage[<>]{<>} <>", { i(1), i(2), i(0) })),
  s(
    { trig = "header", snippetType = "autosnippet" },
    fmta(
      [[
        \lhead{<>}
        \rhead{<>}
      ]],
      {
        i(1, "subject"),
        i(2, "topic"),
      }
    )
  ),
  ----------------------------LaTeX Enviroments----------------------------------

  s(
    { trig = "begg", dscr = "A LaTeX environment", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
         <>
      \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),

  s(
    { trig = "mk", snippetType = "autosnippet" },
    fmta([[\(<>\)<>]], {
      d(1, get_visual),
      i(0),
    })
  ),

  s(
    { trig = "dm", snippetType = "autosnippet" },
    fmta([[\[<>\]<>]], {
      d(1, get_visual),
      i(0),
    })
  ),

  s(
    { trig = "case" },
    fmta(
      [[
      \begin{cases}
      <>
      \end{cases}
      ]],
      {
        i(1),
      }
    ),
    { condition = in_mathzone }
  ),

  s(
    { trig = ";fig", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{figure}[ht]
      \centering
      \includegraphics[scale=0.5]{<>}
      \caption{<>}
      \label{<>}
      \end{figure}
      ]],
      {
        i(1, "Url"),
        i(2, "Caption"),
        i(3, "Label"),
      }
    )
  ),

  s(
    { trig = ";img", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{figure}[H]
      \centering
      \includegraphics[scale=0.5]{<>}
      \end{figure}
      ]],
      {
        i(1, "Url"),
      }
    )
  ),

  s(
    { trig = "([^%a])hr", regTrig = true, wordTrig = false, dscr = "hyperlink", snippetType = "autosnippet" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),

  s(
    { trig = "enr", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{enumerate}
	    \item <>
      \end{enumerate}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),

  s(
    { trig = "itm", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{itemize}
	    \item <>
      \end{itemize}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),

  -----------------------Wrap text in LaTeX environments----------------------------
  s(
    { trig = "align*", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{align*}
          <>
      \end{align*}
    ]],
      { d(1, get_visual) }
    )
  ),

  s(
    { trig = "eqn", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{equation*}
          <>
      \end{equation*}
      ]],
      { d(1, get_visual) }
    )
  ),

  s(
    { trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command.", snippetType = "autosnippet" },
    fmta("\\textit{<>} <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  s(
    { trig = "tbb", snippetType = "autosnippet" },
    fmta("\\textbf{<>} <>", {
      d(1, get_visual),
      i(0),
    })
  ),

  s(
    { trig = "tuu", snippetType = "autosnippet" },
    fmta("\\underline{<>} <>", {
      d(1, get_visual),
      i(0),
    })
  ),
  s(
    { trig = "h1", dscr = "Top-level section", snippetType = "autosnippet" },
    fmta([[\section{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s(
    { trig = "h2", dscr = "second-level section", snippetType = "autosnippet" },
    fmta([[\subsection{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s(
    { trig = "h3", dscr = "third-level section", snippetType = "autosnippet" },
    fmta([[\subsubsection{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s(
    { trig = "H1", dscr = "Top-level section unnumbered", snippetType = "autosnippet" },
    fmta([[\section*{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s(
    { trig = "H2", dscr = "second-level section unnumbered", snippetType = "autosnippet" },
    fmta([[\subsection*{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s(
    { trig = "h1", dscr = "Top-level section", snippetType = "autosnippet" },
    fmta([[\section{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),
  s(
    { trig = "H3", dscr = "third-level section unnumbered", snippetType = "autosnippet" },
    fmta([[\subsubsection*{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s(
    { trig = "section1", dscr = "Top-level section", snippetType = "autosnippet" },
    fmta([[\section{<>}]], { d(1, get_visual) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),
  s(
    { trig = "section2", dscr = "second-level section", snippetType = "autosnippet" },
    fmta([[\subsection{<>}]], { d(1, get_visual) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),
  s(
    { trig = "section3", dscr = "third-level section", snippetType = "autosnippet" },
    fmta([[\subsubsection{<>}]], { d(1, get_visual) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),
  s(
    { trig = "tt", snippetType = "autosnippet" },
    fmta("\\text{<>}<>", { d(1, get_visual), i(0) }),
    { condition = in_mathzone }
  ),
}
