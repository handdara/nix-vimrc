local map = vim.keymap.set

return function()
    map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- space is my leader key
    -- map({ 'n', 'x' }, ';', ':', { silent = true })
    -- map({ 'n', 'x' }, ':', ';', { silent = true })
    map('n', 'Q', '<Nop>', { silent = true })
    map('i', 'jk', '<Esc>')                                  -- Better feeling exit insert mode
    map('i', 'kj', '<Esc>')                                  -- Better feeling exit insert mode
    map('t', '<C-/><C-/>', '<C-\\><C-n>')                    -- Better feeling exit term mode
    map({ 'n', 'v' }, "<leader>y", [["+y]])                  -- Access system clipboard
    map('n', "<leader>Y", [["+Y]])
    map('n', "<leader>PP", [["+p]], { desc = '[P]aste system clipboard' })
    map('v', "<leader>p", [["_dP]]) -- Dont overwrite after pasting over text

    -- sorting paragraphs
    map('v', '<leader>s', '!sort<CR>', { desc = '[S]ort highlighted' })
    map('v', '<leader>S', '!sort -r<CR>', { desc = 'reverse [S]ort highlighted' })
    map('v', '<leader>y', '!yq -y<CR>', { desc = 'clean up YAML with yq' })

    map('n', '<leader>dt', '<CMD>r!date -u \'+\\%F \\%H\\%M\'<CR>', { desc = 'insert [D]ate [T]ime' })

    -- Diagnostic, quickfix, location, keymaps
    map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    map('n', ']q', ':cnext<CR>', { desc = 'next in [q]uickfix list' })
    map('n', '[q', ':cprev<CR>', { desc = 'prev in [q]uickfix list' })
    map('n', ']l', ':lnext<CR>', { desc = 'next in [l]ocation list' })
    map('n', '[l', ':lprev<CR>', { desc = 'prev in [l]ocation list' })

    -- working with views
    map('n', 'zl', '<CMD>loadview<CR>', { desc = 'load [v]iew for current file' })
    map('n', 'zk', '<CMD>mkview<CR>', { desc = 'ma[k]e view for current file' })

    map('n', '<leader>ns', '<CMD>StacheOpenTask<CR>', { desc = 'open stache task on current line' })

    map('n', 'ZB', '<CMD>bufdo bd<CR>', { desc = 'Close all [B]uffers' })
    map('n', '<leader>se', '<CMD>StacheRun<CR>', {desc = 'Run stache blocks in current buffer'})
    map('n', '<leader><leader>s', '<CMD>StacheRunAll<CR>', {desc = 'Run stache blocks in current buffer'})
end
