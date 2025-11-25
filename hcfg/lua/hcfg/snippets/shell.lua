---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "bash"
require('luasnip.session.snippet_collection').clear_snippets "dash"
require('luasnip.session.snippet_collection').clear_snippets "sh"
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

local S = {}
local function use(...)
    table.insert(S, s(...))
end

local casetxt = [[
case {1} in
    {2}) 
        {3}
        ;;
    *)
        echo 'whoops!' >&2
        exit -1 
        ;;
esac 
]]
use('case', fmt(casetxt,{
    c(1, {
        { t'$', i(1, "var") },
        { t'$(', i(1, "cmd"), t')' },
    }),
    i(2,'cal|val*'),
    i(3,[[echo 'found cal or something starting with "val"']]),
}))

ls.add_snippets("bash", S)
ls.add_snippets("dash", S)
ls.add_snippets("sh", S)
