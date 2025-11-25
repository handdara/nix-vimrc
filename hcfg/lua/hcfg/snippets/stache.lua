---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "yaml"
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
local fmta = require("luasnip.extras.fmt").fmt

local S = {}
local function use(...)
    table.insert(S, s(...))
end

local function mkdatenode(fmtstr)
    return f(function()
        return os.date(fmtstr)
    end)
end

local function mkCStacheContexts(idx)
    local cs = {}
    local res = vim.system({'stache', '--get-var', 'STACHE_CNTXS'}, { text = true }):wait()
    assert(res.code == 0)
    local contexts = vim.split(vim.trim(res.stdout), ",", {trimempty=true})
    for _, val in ipairs(contexts) do
        table.insert(cs, t(val))
    end
    table.insert(cs, i(1, 'custom'))
    return c(idx, cs)
end
use('cntx', { mkCStacheContexts(1) })

local function mkCLocations(idx)
    local locs = { 'hm-373', 'hm-369', 'hm-3802', 'au-1', 'of-176', }
    local lcs = {}
    for _, val in ipairs(locs) do
        table.insert(lcs, t(val))
    end
    table.insert(lcs, i(1, 'custom'))
    return c(idx, lcs)
end
use('cntx', { mkCLocations(1) })

local function mkCStatuses(idx)
    local ss = {}
    local res = vim.system({'stache', '--get-var', 'STACHE_STATS'}, { text = true }):wait()
    assert(res.code == 0)
    local statuses = vim.split(vim.trim(res.stdout), ",", {trimempty=true})
    for _, val in ipairs(statuses) do
        table.insert(ss, t(val))
    end
    return c(idx, ss)
end
use('stat', { mkCStatuses(1) })

local function mkCPriorities(idx)
    local ps = {}
    local res = vim.system({'stache', '--get-var', 'STACHE_PRIOS'}, { text = true }):wait()
    assert(res.code == 0)
    local priorities = vim.split(vim.trim(res.stdout), ",", {trimempty=true})
    for _, val in ipairs(priorities) do
        table.insert(ps, t(val))
    end
    return c(idx, ps)
end
use('pri', { mkCPriorities(1) })

local function mkListChoiceItem(cs, tDesc, tCustom)
    local cl = {}
    for _, choice in ipairs(cs) do
        local choice_ = string.gsub('- ch: "', 'ch', choice)
        table.insert(cl, { t(choice_), i(1, tDesc), t '"' })
    end
    table.insert(cl, { t '- ', i(1, tCustom), t(': "'), i(2, tDesc), t '"' })
    return cl
end
local bullet_types = {
    date = { 'birthday', 'anniversary', },
    phone = { 'cell', 'home', 'office', 'work', },
    email = { 'personal', 'work', },
    address = { 'personal', 'office', },
}
use('dbul', c(1, mkListChoiceItem(bullet_types.date, "date", 'custom')))
use('pbul', c(1, mkListChoiceItem(bullet_types.phone, "phone-#", 'other')))
use('ebul', c(1, mkListChoiceItem(bullet_types.email, "email", 'other')))
use('abul', c(1, mkListChoiceItem(bullet_types.address, 'address', 'other')))

local function mkSnSubtask(idx, indent)
    indent = indent or ''
    return sn(idx, {
        t(indent .. '- description: '), i(1),
        t { '', indent .. '  status: ' }, mkCStatuses(2),
        t { '', indent .. '  id: ' }, c(3, {
        t '~',
        { i(1, 'name-0') },
    })
    })
end
use('stsk', mkSnSubtask(1))

ls.add_snippets("yaml", S)
