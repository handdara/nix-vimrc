---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "markdown"
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
local function use(...)
    table.insert(S, s(...))
end

local filetypes = { 'yaml', 'just', 'lua', 'markdown', 'matlab', 'nix', 'tex', 'zig', 'rust', 'python', 'fish', 'bash', 'haskell' }

for _, val in ipairs(filetypes) do
    local function mkCodeBlockSnip(ft)
        return use(ft, { t { '```' .. ft, '' }, i(1), t { '', '```' } })
    end
    mkCodeBlockSnip(val)
end
use('cbl', { t { '```', '' }, i(1), t { '', '```' } })

local bdc = [[
```dc
8k
{1}
f
```
]]
use('dc', fmt(bdc, {
    i(1, '5 v 1 + 2 / p')
}))

local btasks = [[
stache \
    -utt \
    -mf'status,closed' \
    -mf'status,archived' \
    -ps -F '### %s' \
    -pp -rF NONE \
    -l
]]
use('tsks',fmta(btasks, {}))

ls.add_snippets("markdown", S)
