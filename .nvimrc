version 6.0
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-G>S <Plug>(nvim-surround-insert-line)
inoremap <C-G>s <Plug>(nvim-surround-insert)
inoremap <C-W> u
inoremap <C-U> u
tnoremap  <Nop>
tnoremap  
nnoremap  <Cmd>nohlsearch|diffupdate|normal! 
nmap  d
nnoremap  nls <Cmd>Obsidian links
nnoremap  nc <Cmd>Obsidian toc
nnoremap  ng <Cmd>Obsidian search
nnoremap  nb <Cmd>Obsidian backlinks
nnoremap  nn <Cmd>Obsidian new
nnoremap  nf <Cmd>Obsidian quick_switch
nnoremap  nz <Cmd>Obsidian yesterday
nnoremap  nA <Cmd>Obsidian tomorrow
nnoremap  na <Cmd>Obsidian today
nnoremap  nt <Cmd>Obsidian tags
nnoremap  ut :UndotreeShow
xnoremap  /:FzfLua grep_visual
nnoremap  gz :FzfLua git_stash
nnoremap  gt :FzfLua git_tags
nnoremap  gs :FzfLua git_status
nnoremap  gh :FzfLua git_hunks
nnoremap  gf :FzfLua git_files
nnoremap  gd :FzfLua git_diff
nnoremap  gC :FzfLua git_commits
nnoremap  gc :FzfLua git_bcommits
nnoremap  gb :FzfLua git_branches
nnoremap  gB :FzfLua git_blame
nnoremap  sz :FzfLua zoxide
nnoremap  sx :FzfLua files cwd=~/.config fd_opts=-u
nnoremap  sT :FzfLua treesitter
nnoremap  st :FzfLua tags
nnoremap  ss :FzfLua files cwd=~/code/scripts
nnoremap  sr :FzfLua resume
nnoremap  sq :FzfLua resume
nnoremap  sp :FzfLualsp
nnoremap  so :FzfLua oldfiles
nnoremap  sn :FzfLua files cwd=~/code/nix-vimrc
nnoremap  sm :FzfLua manpages
nnoremap  sk :FzfLua keymaps
nnoremap  si :FzfLua
nnoremap  sg :FzfLua live_grep rg_opts=--no-ignore\ --line-number\ --column
nnoremap  s; :FzfLua command_history
nnoremap  sF :FzfLua files fd_opts=-u
nnoremap  sd :FzfLua files cwd=~/code/dotfiles
nnoremap  sc :FzfLua files cwd=~/code
nnoremap  sb :FzfLua buffers
nnoremap  sa :FzfLua global
nnoremap  / :FzfLua blines
nnoremap   / :FzfLua lines
nnoremap  hx :Gitsigns undo_stage_hunk
nnoremap  hw :Gitsigns toggle_word_diff
nnoremap  hs :Gitsigns stage_hunk
nnoremap  hR :Gitsigns refresh:Gitsigns toggle_current_line_blame
nnoremap  hr :Gitsigns reset_hunk
nnoremap  hp :Gitsigns preview_hunk
nnoremap  hb :Gitsigns blame
xnoremap  x !bash
xnoremap  S !sort --reverse
xnoremap  s !sort
xnoremap  b !boxes -d parchment
nnoremap  y "+y
nnoremap  tw :!tmux neww
nnoremap  ts :!tmux split
nnoremap  sh :FzfLua helptags
nnoremap  sf :FzfLua files
nnoremap  lg :term lazygiti
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nnoremap & :&&
nnoremap : ;
nnoremap ; :
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
xnoremap S <Plug>(nvim-surround-visual)
nnoremap Y y$
nnoremap [h :Gitsigns prev_hunk
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nnoremap ]h :Gitsigns next_hunk
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
nnoremap cS <Plug>(nvim-surround-change-line)
nnoremap cs <Plug>(nvim-surround-change)
nnoremap ds <Plug>(nvim-surround-delete)
nnoremap grd :FzfLua lsp_definitions
xnoremap gS <Plug>(nvim-surround-visual-line)
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
nnoremap grr :FzfLua lsp_references
xnoremap ih :Gitsigns select_hunk
onoremap ih :Gitsigns select_hunk
nnoremap ySS <Plug>(nvim-surround-normal-cur-line)
nnoremap yS <Plug>(nvim-surround-normal-line)
nnoremap yss <Plug>(nvim-surround-normal-cur)
nnoremap ys <Plug>(nvim-surround-normal)
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_file(vim.fn.expand("%:p"))
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
tnoremap <C-C> <Nop>
tnoremap <C-C><C-C> 
nmap <C-W><C-D> d
nnoremap <C-L> <Cmd>nohlsearch|diffupdate|normal! 
inoremap S <Plug>(nvim-surround-insert-line)
inoremap s <Plug>(nvim-surround-insert)
inoremap  u
inoremap  u
inoremap jk 
let &cpo=s:cpo_save
unlet s:cpo_save
set expandtab
set formatoptions=cqj
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ -uu\ 
set helplang=en
set nohlsearch
set ignorecase
set packpath=/nix/store/h5rmjhfjih11rgv3j213ajngwxlv0z8m-packpath,~/.config/nvim-custom,/etc/xdg/nvim-custom,~/.nix-profile/etc/xdg/nvim-custom,/nix/profile/etc/xdg/nvim-custom,~/.local/state/nix/profile/etc/xdg/nvim-custom,/etc/profiles/per-user/handdara/etc/xdg/nvim-custom,/nix/var/nix/profiles/default/etc/xdg/nvim-custom,/run/current-system/sw/etc/xdg/nvim-custom,~/.local/share/nvim-custom/site,/nix/store/dmlqg6vj6wpnhmc814f009qndpxq7hwz-ghostty-1.2.3/share/nvim-custom/site,/nix/store/6546hslddlnvg5fmx8vv3man2blcprib-gsettings-desktop-schemas-49.1/share/gsettings-schemas/gsettings-desktop-schemas-49.1/nvim-custom/site,/nix/store/6p5rji9bpkrqlskw88cajh4bc2bhz840-gtk4-4.20.3/share/gsettings-schemas/gtk4-4.20.3/nvim-custom/site,/nix/store/al8g5pm6ld41snjzwcqdxvbvb5np57hk-desktops/share/nvim-custom/site,~/.nix-profile/share/nvim-custom/site,/nix/profile/share/nvim-custom/site,~/.local/state/nix/profile/share/nvim-custom/site,/etc/profiles/per-user/handdara/share/nvim-custom/site,/nix/var/nix/profiles/default/share/nvim-custom/site,/run/current-system/sw/share/nvim-custom/site,/nix/store/q8x36vpi3y15klrf1fkf2bc002vi1w8d-neovim-unwrapped-0.11.5/share/nvim/runtime,/nix/store/q8x36vpi3y15klrf1fkf2bc002vi1w8d-neovim-unwrapped-0.11.5/lib/nvim,/run/current-system/sw/share/nvim-custom/site/after,/nix/var/nix/profiles/default/share/nvim-custom/site/after,/etc/profiles/per-user/handdara/share/nvim-custom/site/after,~/.local/state/nix/profile/share/nvim-custom/site/after,/nix/profile/share/nvim-custom/site/after,~/.nix-profile/share/nvim-custom/site/after,/nix/store/al8g5pm6ld41snjzwcqdxvbvb5np57hk-desktops/share/nvim-custom/site/after,/nix/store/6p5rji9bpkrqlskw88cajh4bc2bhz840-gtk4-4.20.3/share/gsettings-schemas/gtk4-4.20.3/nvim-custom/site/after,/nix/store/6546hslddlnvg5fmx8vv3man2blcprib-gsettings-desktop-schemas-49.1/share/gsettings-schemas/gsettings-desktop-schemas-49.1/nvim-custom/site/after,/nix/store/dmlqg6vj6wpnhmc814f009qndpxq7hwz-ghostty-1.2.3/share/nvim-custom/site/after,~/.local/share/nvim-custom/site/after,/run/current-system/sw/etc/xdg/nvim-custom/after,/nix/var/nix/profiles/default/etc/xdg/nvim-custom/after,/etc/profiles/per-user/handdara/etc/xdg/nvim-custom/after,~/.local/state/nix/profile/etc/xdg/nvim-custom/after,/nix/profile/etc/xdg/nvim-custom/after,~/.nix-profile/etc/xdg/nvim-custom/after,/etc/xdg/nvim-custom/after,~/.config/nvim-custom/after
set path=.,,,**
set runtimepath=/nix/store/h5rmjhfjih11rgv3j213ajngwxlv0z8m-packpath,/nix/store/h5rmjhfjih11rgv3j213ajngwxlv0z8m-packpath/pack/*/start/*,~/.config/nvim-custom,/etc/xdg/nvim-custom,~/.nix-profile/etc/xdg/nvim-custom,/nix/profile/etc/xdg/nvim-custom,~/.local/state/nix/profile/etc/xdg/nvim-custom,/etc/profiles/per-user/handdara/etc/xdg/nvim-custom,/nix/var/nix/profiles/default/etc/xdg/nvim-custom,/run/current-system/sw/etc/xdg/nvim-custom,~/.local/share/nvim-custom/site,/nix/store/dmlqg6vj6wpnhmc814f009qndpxq7hwz-ghostty-1.2.3/share/nvim-custom/site,/nix/store/6546hslddlnvg5fmx8vv3man2blcprib-gsettings-desktop-schemas-49.1/share/gsettings-schemas/gsettings-desktop-schemas-49.1/nvim-custom/site,/nix/store/6p5rji9bpkrqlskw88cajh4bc2bhz840-gtk4-4.20.3/share/gsettings-schemas/gtk4-4.20.3/nvim-custom/site,/nix/store/al8g5pm6ld41snjzwcqdxvbvb5np57hk-desktops/share/nvim-custom/site,~/.nix-profile/share/nvim-custom/site,/nix/profile/share/nvim-custom/site,~/.local/state/nix/profile/share/nvim-custom/site,/etc/profiles/per-user/handdara/share/nvim-custom/site,/nix/var/nix/profiles/default/share/nvim-custom/site,/run/current-system/sw/share/nvim-custom/site,/nix/store/q8x36vpi3y15klrf1fkf2bc002vi1w8d-neovim-unwrapped-0.11.5/share/nvim/runtime,/nix/store/q8x36vpi3y15klrf1fkf2bc002vi1w8d-neovim-unwrapped-0.11.5/share/nvim/runtime/pack/dist/opt/netrw,/nix/store/q8x36vpi3y15klrf1fkf2bc002vi1w8d-neovim-unwrapped-0.11.5/share/nvim/runtime/pack/dist/opt/matchit,/nix/store/q8x36vpi3y15klrf1fkf2bc002vi1w8d-neovim-unwrapped-0.11.5/lib/nvim,/nix/store/h5rmjhfjih11rgv3j213ajngwxlv0z8m-packpath/pack/*/start/*/after,/run/current-system/sw/share/nvim-custom/site/after,/nix/var/nix/profiles/default/share/nvim-custom/site/after,/etc/profiles/per-user/handdara/share/nvim-custom/site/after,~/.local/state/nix/profile/share/nvim-custom/site/after,/nix/profile/share/nvim-custom/site/after,~/.nix-profile/share/nvim-custom/site/after,/nix/store/al8g5pm6ld41snjzwcqdxvbvb5np57hk-desktops/share/nvim-custom/site/after,/nix/store/6p5rji9bpkrqlskw88cajh4bc2bhz840-gtk4-4.20.3/share/gsettings-schemas/gtk4-4.20.3/nvim-custom/site/after,/nix/store/6546hslddlnvg5fmx8vv3man2blcprib-gsettings-desktop-schemas-49.1/share/gsettings-schemas/gsettings-desktop-schemas-49.1/nvim-custom/site/after,/nix/store/dmlqg6vj6wpnhmc814f009qndpxq7hwz-ghostty-1.2.3/share/nvim-custom/site/after,~/.local/share/nvim-custom/site/after,/run/current-system/sw/etc/xdg/nvim-custom/after,/nix/var/nix/profiles/default/etc/xdg/nvim-custom/after,/etc/profiles/per-user/handdara/etc/xdg/nvim-custom/after,~/.local/state/nix/profile/etc/xdg/nvim-custom/after,/nix/profile/etc/xdg/nvim-custom/after,~/.nix-profile/etc/xdg/nvim-custom/after,/etc/xdg/nvim-custom/after,~/.config/nvim-custom/after
set scrolloff=5
set shiftwidth=4
set smartcase
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set termguicolors
set undofile
set window=43
" vim: set ft=vim :
