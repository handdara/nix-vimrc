return function()
    vim.api.nvim_create_user_command('W', 'write', {})
    vim.api.nvim_create_user_command('Wq', 'wq', {})
    vim.api.nvim_create_user_command('Q', 'quit', {})
    vim.api.nvim_create_user_command('Qa', 'qall', {})
    vim.api.nvim_create_user_command('Wqa', 'wqall', {})
end
