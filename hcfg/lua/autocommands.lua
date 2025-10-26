return function()
    -- use register `z` as last location
    local zmark_group = vim.api.nvim_create_augroup('ZMarkPrevLoc', { clear = true })
    vim.api.nvim_create_autocmd('BufLeave', {
        callback = function()
            vim.cmd [[mark z]]
        end,
        group = zmark_group,
        pattern = '*',
    })

    local calcurse = vim.api.nvim_create_augroup('CalcurseMarkdown', { clear = true })
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        callback = function()
            vim.bo.filetype = "markdown"
        end,
        group = calcurse,
        pattern = '/tmp/calcurse*',
    })
    local calcurse_nts = vim.api.nvim_create_augroup('CalcurseNotes', { clear = true })
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        callback = function()
            vim.bo.filetype = "markdown"
        end,
        group = calcurse_nts,
        pattern = '~/.local/share/calcurse/notes/*',
    })
    -- Highlight when yanking (copying) text
    vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
        callback = function()
            vim.highlight.on_yank()
        end,
    })
end
