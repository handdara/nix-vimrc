-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
local stachePattern = { '*/.stache/*', '*/*-stache/*' }
local stache_enter = vim.api.nvim_create_augroup('StacheEnter', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    callback = function()
        if string.len(vim.bo.filetype) < 1 then
            vim.bo.filetype = "yaml"
        end
    end,
    group = stache_enter,
    pattern = stachePattern,
})
