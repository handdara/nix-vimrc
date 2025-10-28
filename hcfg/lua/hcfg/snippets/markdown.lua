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

local S = {}
local function use(snip)
    table.insert(S, snip)
end

local filetypes = { 'yaml', 'just', 'lua', 'markdown', 'matlab', 'nix', 'tex', 'zig', 'rust', 'python', 'fish', 'bash', 'haskell' }

for _, val in ipairs(filetypes) do
    local function mkCodeBlockSnip(ft)
        return s(ft, { t { '```' .. ft, '' }, i(1), t { '', '```' } })
    end
    use(mkCodeBlockSnip(val))
end
use(s('cbl', { t { '```', '' }, i(1), t { '', '```' } }))

ls.add_snippets("markdown", S)
