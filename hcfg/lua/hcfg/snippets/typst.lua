---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "typst"
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

local S = {}
local function use(snip)
    table.insert(S, snip)
end

---@param idx integer
---@return table "snippet node"
local function typcond(idx)
    return sn(idx, { i(1, '1 < 2') })
end

local btemplate = [[
#import "@preview/cheq:0.2.2": checklist
#show: checklist

#set page(
    margin: 1in,
    header: [
        #set text(8pt)
        #smallcaps[New Document]
        #h(1fr) #datetime.today().display()
    ],
    columns: 2,
    numbering: "1",
    "us-letter"
)
#set par(justify: true)
#set math.equation(numbering: "(1)")

#outline()

= Introduction
#lorem(10)

== #lorem(1)

#lorem(100)

== #lorem(2)

#lorem(250)
]]
use(s("newd", fmt(btemplate, {})))

local bblk = [[
{
    <1>
}
]]
local function typcontent(idx)
    return c(idx, {
        {t'[',i(1, "TODO: content"),t']'},
        fmta(bblk,{i(1, '-- TODO: content')}),
    })
end

local bif = [[
if <1> <3> else if <2> <4> else <5>
]]
use(s("if", fmta(bif, {
    typcond(1),
    typcond(3),
    typcontent(2),
    typcontent(4),
    typcontent(5),
})))

use(s({ trig = '__', snippetType = 'autosnippet', wordTrig = false }, { t '_(', i(1), t ')' }))
use(s({ trig = '_*', snippetType = 'autosnippet', wordTrig = false }, { t '_(', i(1), t ')^(', i(2), t ')' }))
use(s({ trig = '**', snippetType = 'autosnippet', wordTrig = false }, { t '^(', i(1), t ')' }))
use(s({ trig = '*_', snippetType = 'autosnippet', wordTrig = false }, { t '^(', i(1), t ')_(', i(2), t ')' }))
use(s({ trig = '$$', snippetType = 'autosnippet', wordTrig = false }, { t '$', i(1), t '$' }))
use(s({ trig = '$  ', snippetType = 'autosnippet', wordTrig = false }, { t '$ ', i(1), t ' $' }))

ls.add_snippets("typst", S)
