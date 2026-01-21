require 'hcfg-pre'

pcall(function() require('nvim-surround').setup {} end)

local foundBlink = pcall(function() require 'blink.cmp' end)
local foundFzfLua = pcall(function() require 'fzf-lua' end)
local foundGit = pcall(function() vim.system({ 'git', '--version' }):wait() end)
local foundGitsigns = pcall(function() return require('gitsigns').setup {} end)
local foundLuasnip = pcall(function() return require 'luasnip' end)
local foundMiniFiles = pcall(function() require 'mini.files' end)
local foundObsidian = pcall(function() require 'obsidian' end)
local foundOil = pcall(function() require 'oil' end)
local foundStache = pcall(function() vim.system({ 'stache', '--version' }):wait() end)

if foundGitsigns and foundGit then
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
    vim.keymap.set({ 'o', 'x' }, 'ih', ':Gitsigns select_hunk<cr>')
end

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
        { desc = '[O]pen file browser at current file' }
    )
    vim.keymap.set('n', '<leader>o', function() MiniFiles.open() end, { desc = '[O]pen file browser' })
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
            local win_id = args.data.win_id
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
    local set_mark = function(id, path, desc)
        MiniFiles.set_bookmark(id, path, { desc = desc })
    end
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesExplorerOpen',
        callback = function()
            set_mark('c', vim.fn.getcwd, 'Working dir')
            set_mark('~', '~', 'Home dir')
        end,
    })
end

if foundOil then
    local oil = require("oil")
    local detail = false
    local simpleCols = {
        { "icon", add_padding = true },
    }
    local detailedCols = {
        { "icon",      add_padding = true },
        { "size",      highlight = "Special", },
        { "mtime",     highlight = "Normal", },
        { "birthtime", highlight = "Special", },
    }
    oil.setup({
        columns = simpleCols,
        keymaps = {
            ["~"] = { "<cmd>Oil ~<CR>", desc = "Open home directory" },
            ["<leader>sf"] = {
                function()
                    if foundFzfLua then
                        require("fzf-lua").files({ cwd = oil.get_current_dir() })
                    end
                end,
                mode = "n",
                nowait = true,
                desc = "Find files in the current directory"
            },
            ["<leader>;"] = {
                "actions.open_cmdline",
                opts = {
                    shorten_path = true,
                    modify = ":h",
                },
                desc = "Open the command line with the current directory as an argument",
            },
            ["<S-Up>"] = "actions.preview_scroll_up",
            ["<S-Down>"] = "actions.preview_scroll_down",
            ["gyy"] = "actions.yank_entry",
            ["<leader><cr>"] = {
                callback = function()
                    vim.cmd("tab term cd '" .. oil.get_current_dir() .. "' && bash")
                end,
                desc = "Open a terminal in a new tab at the current directory",
            },
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        oil.set_columns(detailedCols)
                    else
                        oil.set_columns(simpleCols)
                    end
                end,
            },
        },
    })
    vim.keymap.set('n', '<leader>o', '<cmd>Oil --float<cr>', { desc = '[O]pen file browser' })
end

if foundFzfLua then
    vim.cmd [[FzfLua register_ui_select]]
    vim.cmd [[nnoremap <leader>/ :FzfLua blines<cr>]]
    vim.cmd [[nnoremap <leader>gB :FzfLua git_blame<cr>]]
    vim.cmd [[nnoremap <leader>gb :FzfLua git_branches<cr>]]
    vim.cmd [[nnoremap <leader>gc :FzfLua git_bcommits<cr>]]
    vim.cmd [[nnoremap <leader>gC :FzfLua git_commits<cr>]]
    vim.cmd [[nnoremap <leader>gd :FzfLua git_diff<cr>]]
    vim.cmd [[nnoremap <leader>gf :FzfLua git_files<cr>]]
    vim.cmd [[nnoremap <leader>gh :FzfLua git_hunks<cr>]]
    vim.cmd [[nnoremap <leader>gs :FzfLua git_status<cr>]]
    vim.cmd [[nnoremap <leader>gt :FzfLua git_tags<cr>]]
    vim.cmd [[nnoremap <leader>gz :FzfLua git_stash<cr>]]
    vim.cmd [[nnoremap <leader><leader>/ :FzfLua lines<cr>]]
    vim.cmd [[nnoremap <leader>sa :FzfLua global<cr>]]
    vim.cmd [[nnoremap <leader>sb :FzfLua buffers<cr>]]
    vim.cmd [[nnoremap <leader>sc :FzfLua files cwd=~/code<cr>]]
    vim.cmd [[nnoremap <leader>sd :FzfLua files cwd=~/code/dotfiles<cr>]]
    vim.cmd [[nnoremap <leader>sf :FzfLua files<cr>]]
    vim.cmd [[nnoremap <leader>sF :FzfLua files fd_opts=-u<cr>]]
    vim.cmd [[nnoremap <leader>s; :FzfLua command_history<cr>]]
    vim.cmd [[nnoremap <leader>sg :FzfLua live_grep rg_opts=--no-ignore\ --line-number\ --column<cr>]]
    vim.cmd [[nnoremap <leader>sh :FzfLua helptags<cr>]]
    vim.cmd [[nnoremap <leader>si :FzfLua<cr>]]
    vim.cmd [[nnoremap <leader>sk :FzfLua keymaps<cr>]]
    vim.cmd [[nnoremap <leader>sm :FzfLua manpages<cr>]]
    vim.cmd [[nnoremap <leader>sn :FzfLua files cwd=~/code/nix-vimrc<cr>]]
    vim.cmd [[nnoremap <leader>so :FzfLua oldfiles<cr>]]
    vim.cmd [[nnoremap <leader>sp :FzfLua<cr>lsp]]
    vim.cmd [[nnoremap <leader>sq :FzfLua resume<cr>]]
    vim.cmd [[nnoremap <leader>sr :FzfLua resume<cr>]]
    vim.cmd [[nnoremap <leader>ss :FzfLua files cwd=~/code/scripts<cr>]]
    vim.cmd [[nnoremap <leader>st :FzfLua tags<cr>]]
    vim.cmd [[nnoremap <leader>sT :FzfLua treesitter<cr>]]
    vim.cmd [[nnoremap <leader>sx :FzfLua files cwd=~/.config fd_opts=-u<cr>]]
    vim.cmd [[nnoremap <leader>sz :FzfLua zoxide<cr>]]
    vim.cmd [[xnoremap <leader>/ :FzfLua grep_visual<cr>]]
    vim.keymap.set('n', 'grr', ':FzfLua lsp_references<cr>', { desc = 'Fzf LSP references' })
    vim.keymap.set('n', 'grd', ':FzfLua lsp_definitions<cr>', { desc = 'Fzf LSP references' })
end

vim.cmd [[nnoremap <leader>ut :UndotreeShow<cr>]]

local capabilities = nil
if foundBlink then
    require 'blink.cmp'.setup {
        enabled = function() return not vim.tbl_contains({}, vim.bo.filetype) end,
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

vim.lsp.config('nil_ls', {
    capabilities = capabilities,
    settings = {
        ['nil'] = {
            formatting = { command = { "nixpkgs-fmt" }, },
        },
    },
})
vim.lsp.config('lua_ls', { capabilities = capabilities })
vim.lsp.config('fortls', { capabilities = capabilities })
vim.lsp.config('bashls', { capabilities = capabilities })
vim.lsp.config('hls', { capabilities = capabilities })
vim.lsp.config('marksman', { capabilities = capabilities })
vim.lsp.config('tinymist', {
    capabilities = capabilities,
    settings = {
        formmaterMode = "typstyle",
        -- exportPdf = "onType", -- defaults to "never"
        sematicTokens = "disable",
    },
})
vim.lsp.enable({ 'tinymist', 'lua_ls', 'fortls', 'bashls', 'hls', 'marksman', 'nil_ls' })

if foundLuasnip then
    local ls = require 'luasnip'
    ls.setup {
        update_events = { "TextChanged", "TextChangedI" }
    }
    vim.keymap.set({ "i" }, "<C-j>", function()
        if ls.expandable() then
            ls.expand()
        else
            if ls.jumpable(1) then ls.jump(1) end
        end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable(-1) then ls.jump(-1) end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { silent = true })
    require 'hcfg.snippets.all'
    require 'hcfg.snippets.fortran'
    require 'hcfg.snippets.just'
    require 'hcfg.snippets.lua'
    require 'hcfg.snippets.markdown'
    require 'hcfg.snippets.matlab'
    require 'hcfg.snippets.nix'
    if foundStache then
        require 'hcfg.snippets.stache'
    end
    require 'hcfg.snippets.shell'
    require 'hcfg.snippets.typst'
end

if foundObsidian then
    local obsidian = require('obsidian')
    local wksps = { '~/MEGA/ansible/', '~/code/tadok/', '~/Documents/' }
    local foundWksp = false
    local wkspPath
    for _, wksp in ipairs(wksps) do
        wkspPath = obsidian.Path.new(wksp)
        if wkspPath:exists() and wkspPath:is_dir() then
            foundWksp = true
        end
    end
    if not foundWksp then
        vim.notify('No obsidian workspaces found, creating one at ' .. wkspPath.filename)
        wkspPath:mkdir({ parents = true })
    end
    vim.keymap.set("n", "<leader>nt", "<CMD>Obsidian tags<CR>")
    vim.keymap.set("n", "<leader>na", "<CMD>Obsidian today<CR>")
    vim.keymap.set("n", "<leader>nA", "<CMD>Obsidian tomorrow<CR>")
    vim.keymap.set("n", "<leader>nz", "<CMD>Obsidian yesterday<CR>")
    vim.keymap.set("n", "<leader>nf", "<CMD>Obsidian quick_switch<CR>")
    vim.keymap.set("n", "<leader>nn", "<CMD>Obsidian new<CR>")
    vim.keymap.set("n", "<leader>nt", "<CMD>Obsidian tags<CR>")
    vim.keymap.set("n", "<leader>nb", "<CMD>Obsidian backlinks<CR>")
    vim.keymap.set("n", "<leader>ng", "<CMD>Obsidian search<CR>")
    vim.keymap.set("n", "<leader>nc", "<CMD>Obsidian toc<CR>")
    vim.keymap.set("n", "<leader>nls", "<CMD>Obsidian links<CR>")
    vim.opt.conceallevel = 1
    obsidian.setup {
        workspaces = {
            { name = "ansible", path = vim.fs.normalize '~/MEGA/ansible/' },
            { name = "tadok",   path = vim.fs.normalize '~/code/tadok/' },
            { name = "docs",    path = vim.fs.normalize '~/Documents/' },
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
        frontmatter = { enabled = true },
        search = {
            sort_by = "modified",
            sort_reversed = true,
        },
        callbacks = {
            enter_note = function(note)
                local maps = {
                    ["<leader>nx"] = { modes = 'v', action = ":Obsidian extract_note<CR>", },
                    ["<leader>nln"] = { modes = 'v', action = ":Obsidian linkNew<CR>", },
                    ["<leader>nll"] = { modes = 'v', action = ":Obsidian link<CR>", },
                }
                for combos, dat in pairs(maps) do
                    vim.keymap.set(dat.modes, combos, dat.action, { buffer = note.bufnr })
                end
            end,
        },
        ui = {
            hl_groups = {
                ObsidianTodo = { bold = true, fg = "#1e90ff" },
                ObsidianDone = { bold = true, fg = "#2f8d59" },
                ObsidianRightArrow = { bold = true, fg = "#ff4400" },
                ObsidianTilde = { bold = true, fg = "#ff0000" },
                ObsidianImportant = { bold = true, fg = "#ff1493" },
                ObsidianBullet = { bold = true, fg = "#1e90ff" },
                ObsidianRefText = { underline = true, fg = "#c792ea" },
                ObsidianExtLinkIcon = { fg = "#c792ea" },
                ObsidianTag = { italic = true, fg = "#1e90ff" },
                ObsidianBlockID = { italic = true, fg = "#1e90ff" },
                ObsidianHighlightText = { bg = "#ff69b4", fg = "#000000" },
            },
        },
        legacy_commands = false,
        checkbox = {
            enabled = true,
            create_new = true,
            order = { " ", "!", ">", "x", "~", },
        },
    }
end

require 'hcfg.autocommands'
require 'hcfg.commands'
require 'hcfg.colocorrect'

require 'hcfg-extra'
