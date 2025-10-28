---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "nix"
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

local bMod = [[
{1}:
{2}
]]

local argList = {
    sn(1, { t '{', i(1, '...'), t '}' }),
    sn(1, { t '{', i(1, 'pkgs, ...'), t '}' }),
    sn(1, { t '{', i(1, 'pkgs, lib, ...'), t '}' }),
    sn(1, { t '{', i(1, 'config, pkgs, lib, ...'), t '}' }),
}
local bodyList = {
    fmt('{{\n    {}\n}}', i(1)),
    sn(1, {
        t { 'let', '    ' }, i(1),
        t { '', 'in', '{', '    ' }, i(2), t { '', '}' },
    }),
}
local sMod = s('mod', fmt(bMod, {
    sn(1, { c(1, argList), i(2, '@inputs') }),
    c(2, bodyList),
}))

local sImp = s('imp', fmt('import {} {{{}}};', {
    c(1, {
        fmt('<{}>', i(1, 'nixpkgs')),
        fmt('./{}', i(1, 'module.nix')),
    }),
    i(2, 'args'),
}))

ls.add_snippets("nix", {
    sMod,
    sImp,
})
