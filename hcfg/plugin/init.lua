-- vim.cmd [[colo boo]]

require 'hcfg.autocommands'
require 'hcfg.commands'

pcall(function() require('nvim-surround').setup{} end)

local foundGitsigns = pcall(function() return require('gitsigns').setup {} end)
if foundGitsigns then
    vim.cmd [[Gitsigns toggle_current_line_blame]]
    vim.cmd [[nnoremap ]h :Gitsigns next_hunk<cr>]]
    vim.cmd [[nnoremap [h :Gitsigns prev_hunk<cr>]]
    vim.cmd [[nnoremap <leader>hb :Gitsigns blame<cr>]]
    vim.cmd [[nnoremap <leader>hp :Gitsigns preview_hunk<cr>]]
    vim.cmd [[nnoremap <leader>hr :Gitsigns reset_hunk<cr>]]
    vim.cmd [[nnoremap <leader>hR :Gitsigns refresh<cr>:Gitsigns toggle_current_line_blame<cr>]]
    vim.cmd [[nnoremap <leader>hs :Gitsigns stage_hunk<cr>]]
    vim.cmd [[nnoremap <leader>hw :Gitsigns toggle_word_diff<cr>]]
    vim.cmd [[nnoremap <leader>hx :Gitsigns undo_stage_hunk<cr>]]
    vim.keymap.set({'o', 'x'}, 'ih', ':Gitsigns select_hunk<cr>')
end

local foundMiniFiles = pcall(function() require 'mini.files' end)
if foundMiniFiles then
require('mini.files').setup({
    content = { filter = nil, prefix = nil, sort = nil, },
    mappings = { -- Module mappings created only inside explorer.
        close       = '<ESC>',
        go_in       = 'l',
        go_in_plus  = '<CR>',
        go_out      = 'h',
        go_out_plus = 'H',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = 's',
        trim_left   = '<',
        trim_right  = '>',
    },
    options = { permanent_delete = false },
    windows = {
        preview = true,
        width_focus = 40, 
        width_nofocus = 30, 
        width_preview = 90,
    },
})
vim.keymap.set('n', '<leader>go', 
function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end, 
{ desc = '[O]pen file browser at current file' })
vim.keymap.set('n', '<leader>o', function() MiniFiles.open() end, { desc = '[O]pen file browser' })
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
        local win_id = args.data.win_id
        local config = vim.api.nvim_win_get_config(win_id)
        vim.wo[win_id].winblend = 0 -- mini.files window transparency
        vim.api.nvim_win_set_config(win_id, { border = 'double' })
    end,
})
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowUpdate',
    callback = function(args)
        local win_id = args.data.win_id
        vim.wo[win_id].number = true
        vim.wo[win_id].relativenumber = true
    end,
})
local set_mark = function (id, path, desc)
    MiniFiles.set_bookmark(id, path, {desc = desc})
end
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesExplorerOpen',
    callback = function ()
        set_mark('c', vim.fn.getcwd, 'Working dir')
        set_mark('~', '~', 'Home dir')
    end,
})
end

local foundFzfLua = pcall(function() require 'fzf-lua' end)
if foundFzfLua then
    vim.cmd [[FzfLua register_ui_select]]
    vim.cmd [[nnoremap <leader><leader>/ :FzfLua lines<cr>]]
    vim.cmd [[nnoremap <leader>/ :FzfLua blines<cr>]]
    vim.cmd [[nnoremap <leader>sa :FzfLua<cr>]]
    vim.cmd [[nnoremap <leader>sb :FzfLua buffers<cr>]]
    vim.cmd [[nnoremap <leader>sc :FzfLua files cwd=~/code<cr>]]
    vim.cmd [[nnoremap <leader>sd :FzfLua files cwd=~/code/dotfiles<cr>]]
    vim.cmd [[nnoremap <leader>sf :FzfLua files<cr>]]
    vim.cmd [[nnoremap <leader>sF :FzfLua files fd_opts=-u<cr>]]
    vim.cmd [[nnoremap <leader>s: :FzfLua command_history<cr>]]
    vim.cmd [[nnoremap <leader>sg :FzfLua live_grep rg_opts=--no-ignore\ --line-number\ --column<cr>]]
    vim.cmd [[nnoremap <leader>sh :FzfLua helptags<cr>]]
    vim.cmd [[nnoremap <leader>si :FzfLua<cr>]]
    vim.cmd [[nnoremap <leader>sk :FzfLua keymaps<cr>]]
    vim.cmd [[nnoremap <leader>sm :FzfLua manpages<cr>]]
    vim.cmd [[nnoremap <leader>so :FzfLua oldfiles<cr>]]
    vim.cmd [[nnoremap <leader>sp :FzfLua<cr>lsp]]
    vim.cmd [[nnoremap <leader>sq :FzfLua resume<cr>]]
    vim.cmd [[nnoremap <leader>sr :FzfLua resume<cr>]]
    vim.cmd [[nnoremap <leader>ss :FzfLua files cwd=~/code/scripts<cr>]]
    vim.cmd [[nnoremap <leader>st :FzfLua tags<cr>]]
    vim.cmd [[nnoremap <leader>sT :FzfLua treesitter<cr>]]
    vim.cmd [[nnoremap <leader>sx :FzfLua files cwd=~/.config fd_opts=-u<cr>]]
    vim.cmd [[nnoremap <leader>sz :FzfLua zoxide<cr>]]
    vim.keymap.set('n', 'grr', ':FzfLua lsp_references<cr>', { desc = 'Fzf LSP references' })
    vim.keymap.set('n', 'grd', ':FzfLua lsp_definitions<cr>', { desc = 'Fzf LSP references' })
end

vim.cmd [[nnoremap <leader>ut :UndotreeShow<cr>]]

local capabilities = nil
local foundBlink = pcall(function() require 'blink.cmp' end)
if foundBlink then
    require'blink.cmp'.setup {
        enabled = function() return not vim.tbl_contains({ }, vim.bo.filetype) end,
        snippets = { preset = 'luasnip' },
        completion = {
            menu = {
                -- auto_show = false,
                auto_show_delay_ms = 1000,
            }
        },
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
    }
    capabilities = require('blink.cmp').get_lsp_capabilities()
end

vim.lsp.enable('nil_ls', {capabilities = capabilities})
vim.lsp.enable('lua_ls', {capabilities = capabilities})
vim.lsp.enable('fortls', {capabilities = capabilities})
vim.lsp.enable('tinymist', {
    capabilities = capabilities,
    settings = {
        formmaterMode = "typstyle",
        -- exportPdf = "onType", -- defaults to "never"
        sematicTokens = "disable",
    },
})

local foundLuasnip = pcall(function() return require'luasnip' end)
if foundLuasnip then
    local ls = require 'luasnip'
    ls.setup {
        update_events = {"TextChanged", "TextChangedI"}
    }
    vim.keymap.set({"i"}, "<C-j>", function() 
        if ls.expandable() then
            ls.expand()
        else
            if ls.jumpable(1) then ls.jump(1) end
        end
    end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-k>", function() 
        if ls.jumpable(-1) then ls.jump(-1) end
    end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-h>", function()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-l>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, {silent = true})
    require 'hcfg.snippets.all'
    require 'hcfg.snippets.fortran'
    require 'hcfg.snippets.just'
    require 'hcfg.snippets.lua'
    require 'hcfg.snippets.markdown'
    require 'hcfg.snippets.matlab'
    require 'hcfg.snippets.nix'
    require 'hcfg.snippets.typst'
end

local foundObsidian = pcall(function() require'obsidian' end)
if foundObsidian then
    vim.keymap.set("n", "<leader>nt" , "<CMD>Obsidian tags<CR>")
    vim.keymap.set("n", "<leader>na" , "<CMD>Obsidian today<CR>")
    vim.keymap.set("n", "<leader>nA" , "<CMD>Obsidian tomorrow<CR>")
    vim.keymap.set("n", "<leader>nz" , "<CMD>Obsidian yesterday<CR>")
    vim.keymap.set("n", "<leader>nf" , "<CMD>Obsidian quick_switch<CR>")
    vim.keymap.set("n", "<leader>nn" , "<CMD>Obsidian new<CR>")
    vim.keymap.set("n", "<leader>nt" , "<CMD>Obsidian tags<CR>")
    vim.keymap.set("n", "<leader>nb" , "<CMD>Obsidian backlinks<CR>")
    vim.keymap.set("n", "<leader>ng" , "<CMD>Obsidian search<CR>")
    vim.keymap.set("n", "<leader>nc" , "<CMD>Obsidian toc<CR>")
    vim.keymap.set("n", "<leader>nls", "<CMD>Obsidian links<CR>")
    vim.opt.conceallevel = 1
    require('obsidian').setup {
        workspaces = {
            { name = "ansible", path = vim.fs.normalize '~/MEGA/ansible/' },
            { name = "tadok", path = vim.fs.normalize '~/code/tadok/' },
        },
        daily_notes = { folder = '1-active-quests/dailies' },
        notes_subdir = '0-quest-board/inbox',
        new_notes_location = "notes_subdir",
        note_id_func = function(title)
            local id = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                id = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                id = tostring(os.time()) .. "-" .. id
                for _ = 1, 4 do
                    id = id .. string.char(math.random(65, 90))
                end
            end
            -- return tostring(os.time()) .. "-" .. id
            return id
        end,
        note_path_func = function(spec)
            local path
            if spec.title then
                path = spec.dir / tostring(spec.title)
            else
                path = spec.dir / tostring(spec.id)
            end
            return path:with_suffix(".md")
        end,
        preferred_link_style = "wiki",
        disable_frontmatter = false,
        sort_by = "modified",
        sort_reversed = true,
        callbacks = {
            enter_note = function(note) 
                local maps = {
                    ["<leader>nx"] = { modes = 'v', action = ":Obsidian extract_note<CR>", },
                    ["<leader>nln"] = { modes = 'v', action = ":Obsidian linkNew<CR>", },
                    ["<leader>nll"] = { modes = 'v', action = ":Obsidian link<CR>", },
                }
                for combos, dat in pairs(maps) do
                    vim.keymap.set(dat.modes, combos, dat.action, {buffer = note.bufnr} )
                end
            end,
        },
        legacy_commands = false,
        checkbox = {
            enabled = true,
            create_new = true,
            order = { " ", "!", ">", "x", "~", },
        },
    }
end
