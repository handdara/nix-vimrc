---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "lua"
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

local bsnipfile = [[
---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "{1}"
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

local S = {{}}
local function use(snip)
    table.insert(S, snip)
end

-- snips go here
{3}

ls.add_snippets("{2}", S)
]]

local S = {}
local function use(snip)
    table.insert(S, snip)
end

local bAutoSnip = [[use(s({{ trig = '{1}', snippetType = 'autosnippet', wordTrig = false }}, {2} ))]]
use(s('aus', fmt(bAutoSnip, { i(1, 'trigger'), i(2, "t('text')") })))
use(s("lsf", fmt(bsnipfile, { i(1), rep(1), i(0) })))

ls.add_snippets("lua", S)
