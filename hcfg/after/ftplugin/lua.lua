vim.keymap.set("n", "<leader>x", "<CMD>.lua<CR>", { desc = "E[x]ecute the current line", buffer = true})

-- local cr = string.char(13)
local esc = string.char(27)
local istr = '^\\"zy$Iprint(vim.inspect(' .. esc .. 'A))' .. esc .. '%a[[]], ' .. esc .. 'hhh\\"zP^'
vim.cmd('let @i="' .. istr .. '"')
