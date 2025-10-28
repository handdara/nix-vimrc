---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "fortran"
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

local todoCmnt = '! TODO...'

local S = {}
local function use(snip)
    table.insert(S, snip)
end

local bPrg = [[
program {1}
    implicit none

    {3}
contains
end program {2} 
]]
use(s('prg', fmt(bPrg,{
    i(1, "name"),
    rep(1),
    i(2, todoCmnt),
})))

local bSubrtn = [[
subroutine {1}
    {3}
end subroutine {2}
]]
use(s('sbr', fmt(bSubrtn,{
    i(1, "name"),
    f(function (args) return string.match(args[1][1], '^[%w%_]+') end, {1}),
    i(2, todoCmnt)
})))

local bFunc = [[
function {1}
    {3}
end function {2}
]]
use(s('fn', fmt(bFunc,{
    i(1, "name"),
    f(function (args) return string.match(args[1][1], '^[%w%_]+') end, {1}),
    i(2, todoCmnt)
})))

local bDo = [[
    {1}do {3} ={4}
        {5}
    end do{2}
]]
use(s('for', fmt(bDo, {
    c(1, {
        {i(1,'loop_name'), t ': ' },
        t'',
    }),
    f(function (args)
        if string.match(args[1][1], ":") then
            local str = string.match(args[1][1], '(.-):')
            return ' ' .. str
        else
            return ''
        end
    end, {1}),
    i(3, 'idx'),
    c(2, {
        {t' 1,',i(1,'10')},
        {t' 1,',i(1,'10'),t',2'},
        {t' ',i(1,'10'),t',1,-1'},
    }),
    -- d(4, function(args) return 'print *, ' .. args[1][1] end, {1}),
    d(4, function(args) return sn(nil, i(1,'print *, ' .. args[1][1])) end, {3}),
})))

local bIf = [[
    {1}if ({3}) then
        {4}
    end if{2}
]]
use(s('if', fmt(bIf, {
    c(1, {
        {i(1,'if_name'), t ': ' },
        t'',
    }),
    f(function (args)
        if string.match(args[1][1], ":") then
            local str = string.match(args[1][1], '(.-):')
            return ' ' .. str
        else
            return ''
        end
    end, {1}),
    i(2, '.false.'),
    i(3, todoCmnt)
})))

ls.add_snippets("fortran", S)
