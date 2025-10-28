---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "tex"
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local function mkBegEnd(args)
    local bbeg = [[
        \begin{{{1}{2}}}
            {3}
        \end{{{4}{5}}}
        ]]
    local e1, e2, body, star1, star2
    if args.env then
        e1 = t(args.env)
        star1 = c(1, { t '*', t '' })
        body = i(2)
        e2 = t(args.env)
        star2 = rep(1)
    else
        e1 = i(1, 'environment')
        star1 = c(2, { t '*', t '' })
        body = i(3)
        e2 = rep(1)
        star2 = rep(2)
    end
    return s(args.trig, fmt(bbeg, { e1, star1, body, e2, star2 }))
end

local bNewCmd = [[\newcommand{{\{1}}}{2}{{{3}}}]]
local sNewCmd = fmt(bNewCmd, { i(1, 'cmd_name'), c(2, { sn(nil, { t '[', i(1), t ']' }), t'' }), i(3) })
local bNomen = [[\nomenclature{{${1}$}}{{{2}}}]]
local sNomen = fmt(bNomen, { i(1), i(2, 'Description') })

local S = {}
local function use(snip)
    table.insert(S, snip)
end
use(mkBegEnd { trig = 'beg', })
use(mkBegEnd { trig = 'equ', env = "equation" })
use(mkBegEnd { trig = 'ali', env = "align" })
use(mkBegEnd { trig = 'lem', env = "lemma" })
use(mkBegEnd { trig = 'def', env = "defn" })
use(mkBegEnd { trig = 'cor', env = "corollary" })
use(mkBegEnd { trig = 'thm', env = "theorem" })
use(mkBegEnd { trig = 'prop', env = "prop" })
use(mkBegEnd { trig = 'not', env = "note" })
use(mkBegEnd { trig = 'remk', env = "remark" })
use(mkBegEnd { trig = 'exmp', env = "example" })
use(mkBegEnd { trig = 'soln', env = "solution" })
use(s("newc", sNewCmd))
use(s("nom", sNomen))
use(s("sec", { t "\\section", c(1, { t '*', t '' }), t "{", i(2), t { '}', '' }, i(0) }))
use(s("sse", { t "\\subsection", c(1, { t '*', t '' }), t "{", i(2), t { '}', '' }, i(0) }))
use(s("sss", { t "\\subsubsection", c(1, { t '*', t '' }), t "{", i(2), t { '}', '' }, i(0) }))
use(s("ss3", { t "\\subsubsubsection", c(1, { t '*', t '' }), t "{", i(2), t { '}', '' }, i(0) }))
use(s('lab', { t "\\label{", i(1), t "}" }))
use(s('ref', { t "\\ref{", i(1), t "}" }))
use(s({ trig = '__', snippetType = 'autosnippet', wordTrig = false }, { t '_{', i(1), t '}' }))
use(s({ trig = '_*', snippetType = 'autosnippet', wordTrig = false }, { t '_{', i(1), t '}^{', i(2), t '}' }))
use(s({ trig = '**', snippetType = 'autosnippet', wordTrig = false }, { t '^{', i(1), t '}' }))
use(s({ trig = '*_', snippetType = 'autosnippet', wordTrig = false }, { t '^{', i(1), t '}_{', i(2), t '}' }))
use(s('{{', { t '\\{ ', i(1), t ' \\}' }))
use(s('((', { t '\\left( ', i(1), t ' \\right)' }))
use(s('[[', { t '\\left[ ', i(1), t ' \\right]' }))
use(s('|', { t '\\left| ', i(1), t ' \\right|' }))
use(s('||', { t '\\left\\| ', i(1), t ' \\right\\|' }))
use(s('<<', { t '\\left< ', i(1), t ' \\right>' }))

ls.add_snippets("tex", S)
