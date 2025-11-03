---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "bash"
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

local function mkdatenode(fmtstr)
    return f(function()
        return os.date(fmtstr)
    end)
end

ls.add_snippets("bash", S)
