local map = vim.keymap.set
local wikilink_regex = '\\[\\[.*\\]\\]'
local mdlink_regex = '\\[[^]]*\\](.*)'
local link_regex = [[\(]].. wikilink_regex ..[[\|]].. mdlink_regex ..[[\)]]
map('n', '<leader>it', '<CMD>r!today<CR>i##<Space><Esc>_',
  { buffer = true, desc = '[i]nsert [t]oday\'s date as heading' })
map('v', '<leader>t', '!pandoc -t gfm<CR>', { buffer = true, desc = 'format highlighted [T]able' })
map('v', '<leader>T', '!pandoc -t markdown_strict+grid_tables<CR>',
  { buffer = true, desc = 'format highlighted [T]able' })
map('n', '<leader>gt', 'vip!pandoc -t ', { buffer = true })
-- vim.opt_local.conceallevel = 1
-- vim.keymap.set('n', '<leader>nt', function()
--   local lc = vim.api.nvim_get_option_value('conceallevel', {})
--   if lc == 0 then
--     vim.opt_local.conceallevel = 1
--   else
--     vim.opt_local.conceallevel = 0
--   end
-- end, { desc = '[n]otes [t]oggle conceal' , buffer = true})
map('n', '<Tab>', '/'.. wikilink_regex ..'<CR>zz', { desc = 'go to next link', buffer = true })
map('n', '<S-Tab>', '?'.. wikilink_regex ..'<CR>zz', { desc = 'go to prev link', buffer = true })
map('n', '<C-Tab>', '/'.. link_regex ..'<CR>zz', { desc = 'go to next link', buffer = true })
map('n', '<C-S-Tab>', '?'.. link_regex ..'<CR>zz', { desc = 'go to prev link', buffer = true })
pcall(function() require('otter').activate() end)
