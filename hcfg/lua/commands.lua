local function clearColAucmds()
    vim.cmd [[augroup ColoGrp]]
    vim.cmd [[augroup END]]
    vim.api.nvim_del_augroup_by_name('ColoGrp')
end
return function()
    vim.api.nvim_create_user_command('W', 'write', {})
    vim.api.nvim_create_user_command('Wq', 'wq', {})
    vim.api.nvim_create_user_command('Q', 'quit', {})
    vim.api.nvim_create_user_command('Qa', 'qall', {})
    vim.api.nvim_create_user_command('Wqa', 'wqall', {})
    vim.api.nvim_create_user_command('FO', 'Fo', {})
    vim.api.nvim_create_user_command('Ranker', function (opts)
        require('handdara.util.ranker').ranker(opts.line1, opts.line2)
    end , { range = true })
    vim.api.nvim_create_user_command('HLight', function ()
        clearColAucmds()
        require 'handdara.config.looks'.init_looks('paper', true)
    end , { range = true })
    vim.api.nvim_create_user_command('HDark', function ()
        require 'handdara.config.looks'.init_looks('lunaperche', false)
    end , { range = true })
    vim.api.nvim_create_user_command('HOpaque', function ()
        local scheme = vim.g.colors_name
        clearColAucmds()
        vim.cmd.colorscheme(scheme)
    end , { range = true })
end
