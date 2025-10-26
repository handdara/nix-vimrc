local function set_looks(colorscheme, is_light)
    local c = colorscheme or "lunaperche" -- default is lunaperche b/c it's my favorite builtin colorscheme
    local light = is_light or false;
    vim.cmd [[hi link GitSignsCurrentLineBlame Comment]]
    local groups = {
        'Normal',
        'NormalNC',
        -- 'Comment',
        -- 'Constant',
        -- 'Special',
        -- 'Identifier',
        -- 'Statement',
        -- 'PreProc',
        -- 'Type',
        -- 'Underlined',
        -- 'Todo',
        -- 'String',
        -- 'Function',
        -- 'Conditional',
        -- 'Repeat',
        -- 'Operator',
        -- 'Structure',
        -- 'LineNr',
        -- 'NonText',
        -- 'SignColumn',
        -- 'CursorLine',
        -- 'CursorLineNr',
        -- 'EndOfBuffer',
    }
    ---@diagnostic disable-next-line: unused-local
    local extra_groups = {
        'NormalFloat',
        'FloatBorder',
        'WhichKeyBorder',
        'FloatTitle',
        'TelescopeBorder',
        'TelescopeNormal',
    }
    local function apply(grps)
        for _, value in ipairs(grps) do
            vim.cmd('highlight ' .. value .. " cterm=none guibg=none")
        end
    end
    if not light then
        vim.o.background = 'dark'
        local colo_grp = vim.api.nvim_create_augroup('ColoGrp', { clear = true })
        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function()
                vim.cmd('highlight Normal cterm=none guibg=none')
                apply(groups)
                apply(extra_groups)
            end,
            group = colo_grp,
            pattern = '*',
        })
    else
        vim.o.background = 'light'
    end
    vim.cmd("colorscheme " .. c)
end

local function init_looks(colorscheme, is_light)
    set_looks(colorscheme, is_light)
    if colorscheme == 'marrissa-only' then
        vim.cmd [[highlight TelescopeMatching gui=bold guifg=#823f8f]]
    elseif colorscheme == 'eva01' or colorscheme == 'eva01-LCL' then
        vim.cmd [[highlight @markup.heading.1.markdown gui=bold,italic guibg=#b968fc guifg=#130114]]
        vim.cmd [[highlight @markup.heading.2.markdown gui=bold,italic guibg=#87FF5f guifg=#130114]]
        vim.cmd [[highlight @markup.heading.3.markdown gui=bold,italic guibg=#85b0e6 guifg=#130114]]
        vim.cmd [[highlight @markup.heading.4.markdown gui=italic      guibg=#f5d6fd guifg=#130114]]
        vim.cmd [[highlight @markup.heading.5.markdown gui=italic      guibg=#a785ff guifg=#130114]]
        vim.cmd [[highlight @markup.heading.6.markdown gui=italic      guibg=#322a33 guifg=#f96f2f]]
    elseif colorscheme == 'retrobox' then
        vim.cmd [[highlight NeogitDiffAddHighlight guibg=#52561b]]
        vim.cmd [[highlight NeogitDiffAdd guibg=#52561b]]
    end
end

return {
    init_looks = init_looks,
    set_looks = set_looks,
}
