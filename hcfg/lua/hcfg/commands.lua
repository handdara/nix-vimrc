vim.api.nvim_create_user_command('W', 'write', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('Q', 'quit', {})
vim.api.nvim_create_user_command('Qa', 'qall', {})
vim.api.nvim_create_user_command('Wqa', 'wqall', {})
vim.api.nvim_create_user_command('ClearBG', function()
    local function clrhl(hlname)
        local hl = vim.api.nvim_get_hl(0, { name = hlname })
        hl.bg = nil
        vim.api.nvim_set_hl(0, hlname, hl)
    end
    clrhl("Normal")
    clrhl("NormalNC")
end, {})
vim.api.nvim_create_user_command('Fdh',
    [[tab term fd -u '' ~ | fzf | xargs -rn1 dirname | xargs nvr]], {})
vim.api.nvim_create_user_command('Format', function(_)
    vim.lsp.buf.format()
end, { desc = 'Format current buffer with LSP' })
vim.api.nvim_create_user_command('ToPDF', function(_)
    vim.cmd [[!nix-shell -p typst --run 'pandoc --pdf-engine=typst -V "mainfont=Tex Gyre Heros" -o "$(echo % | sed "s/\.\w\+/.pdf/")" %']]
end, { desc = 'Format current buffer with LSP' })
vim.api.nvim_create_user_command('PandocMarkdown', function()
    vim.cmd [[!nix-shell -p typst --run 'pandoc --pdf-engine=typst --pdf-engine-opt=--root="$HOME/MEGA/ansible" --pdf-engine-opt=--creation-timestamp=$(date +\%s) --template="$HOME/.config/pandoc/templates/ansible.typ" -i % -t pdf -o /tmp/$(basename "%").pdf']]
    vim.cmd [[!xdg-open /tmp/$(basename "%").pdf &]]
end, {})
