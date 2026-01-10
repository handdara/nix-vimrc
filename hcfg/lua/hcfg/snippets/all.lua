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
            -ps -F'### %s' \
            -pp -rFNONE \
            -lF <1>
    ]], {
        i(1, [['- `~/.stache/{.id}` _{.priority}_ {.description}']]),
    }),
    fmta([[
        stache \
            -ufid,<1> \
            -ntt <2>
            -ps -FNONE \
            -pp -FNONE \
            -lF '- `~/.stache/{.id}`\t{.status}\t{.priority}\t{.description}' \
            | column -ts $'\t'
    ]], {
        i(1, 'id-prefix'),
        c(2, {
            t { '\\', '    -mfstatus,closed \\', '    -mfstatus,archived \\' },
            t '\\',
            { t { '\\', '    -mfstatus,' }, i(1, 'closed'),   t ' \\' },
            { t { '\\', '    -mfstatus,' }, i(1, 'archived'), t ' \\' },
        }),
    }),
}))

use('spfs', fmta(
    [[stache -u<> | xargs -n1 basename | sed 's/\-[^-]\+$//' | uniq]],
    { c(1, { i(1,'tt'), i(1,'U') }) }
))

ls.add_snippets("all", S)
