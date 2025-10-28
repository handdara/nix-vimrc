{
  lib,
  makeWrapper,
  neovim-unwrapped,
  runCommandLocal,
  symlinkJoin,
  version,
  vimPlugins,
  python3,
  gcc,
  gnumake,
  pkg-config,
  nodejs_20,
  luajitPackages,
}:
let

  tsParsers = with vimPlugins.nvim-treesitter-parsers; [
    asm        gnuplot perl
    awk        haskell python
    bibtex     html    r
    cmake      ini     regex
    cpp        jq      rust
    css        json    sql
    csv        just    tcl
    fish       kdl     tmux
    fortran    latex   typst
    gitcommit  luadoc  yaml
    git_rebase make    zig
    gitignore  nix     
  ];
  
  colorthemes = with vimPlugins; [ 
    eva01-vim
    rose-pine
    vim-paper
    boo-colorscheme-nvim
  ];

  plugins = with vimPlugins; [
    blink-cmp
    fzf-lua
    gitsigns-nvim
    luasnip
    mini-files
    nvim-lspconfig
    nvim-surround
    nvim-treesitter
    nvim-web-devicons
    obsidian-nvim
    undotree
  ];

  startPlugins = tsParsers ++ colorthemes ++ plugins;

  packageName = "nix-neovimrc";
  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}
    ln -vsfT ${./hcfg} $out/pack/${packageName}/start/hcfg
    ${lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
    ) startPlugins}
  '';

  pathAdditions = [  
    gcc 
    gnumake
    pkg-config 
    python3 
    nodejs_20 
    luajitPackages.jsregexp 
  ];
in
symlinkJoin {
  name = "nvim-${version}";
  paths = [ neovim-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --prefix PATH : ${lib.makeBinPath pathAdditions} \
      --add-flags '-u' \
      --add-flags '${./dot-vimrc}' \
      --add-flags '--cmd' \
      --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
      --set-default NVIM_APPNAME nvim-custom
  '';
  passthru = {
    inherit packpath;
  };
}
