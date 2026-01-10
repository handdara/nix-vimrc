---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "all"
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

local function mkdatenode(fmtstr)
    return f(function()
        return os.date(fmtstr)
    end)
end

use("day", c(1, {
    mkdatenode('%F'),
    mkdatenode('%0d%b%Y'),
    mkdatenode('%0d %b %Y'),
    mkdatenode('%A, %B %0d, %Y'),
}))

use("tim", c(1, {
    mkdatenode('%H%M'),
    mkdatenode('%H:%M'),
    mkdatenode('%H:%M:%S'),
}))

use("now", c(1, {
    mkdatenode('%F %H%M'),
    mkdatenode('%s'),
}))

use('tsks', c(1, {
    fmta([[
        stache \
            -utt \
            -mfstatus,closed \
            -mfstatus,archived \
            -ps -F '### %s' \
            -pp -rFNONE \
            -lF <1>
    ]], {
        i(1, '- `~/.local/{.id}` _{.priority}_ {.description}'),
    }),
    fmta([[
        stache \
            -fid,<1> \
            -ntt \
            -mfstatus,closed \
            -mfstatus,archived \
            -ps -F '### %s' \
            -pp -rFNONE \
            -lF '- `~/.local/{.id}` _{.priority}_ {.description}'
    ]], {
        i(1, 'id-prefix'),
    }),
}))

ls.add_snippets("all", S)
