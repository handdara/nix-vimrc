---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "just"
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

local bBash = [[
{1}:
    #!/usr/bin/env bash
    set -euxo pipefail
    hello='Yo'
    echo "$hello from Bash!"
]]
local sBash = s('bash-recipe', fmt(bBash, {
    i(1, 'name'),
}))

ls.add_snippets("just", {
    s("jd", t([[jd := justfile_directory()]])),
    s("hd", t[[hd := env_var('HOME')]]),
    s("def", t({'# list recipes', 'default:', '    @just --list', ''})),
    sBash,
})
