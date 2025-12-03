{
  fetchFromGitHub,
  fetchFromGitLab,
  gcc,
  gnumake,
  lib,
  luajitPackages,
  makeWrapper,
  neovim-unwrapped,
  nodejs_20,
  pkg-config,
  python3,
  runCommandLocal,
  symlinkJoin,
  version,
  vimPlugins,
  vimUtils,
  extraLuaConfig ? "",
  extraLuaPreConfig ? "vim.cmd [[colo lackluster]]",
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
    boo-colorscheme-nvim
    eva01-vim
    falcon
    lackluster-nvim
    melange-nvim
    rose-pine
    vim-paper
    (vimUtils.buildVimPlugin {
      name = "monalisa-nvim";
      src = fetchFromGitHub {
        owner = "ptdewey";
        repo = "monalisa-nvim";
        rev = "2ffe6db37fcad17da0d210f5b3a357712d0b8a2b";
        hash = "sha256-5VgsVaClE3cH5uVlRSHEFV3WofHw2P+3rBMF/lQEm+0=";
      };
    })
    (vimUtils.buildVimPlugin {
      name = "halfspace";
      src = fetchFromGitLab {
        owner = "sxwpb";
        repo = "halfspace.nvim";
        rev = "23b367771f694479771735150311d41830133f95";
        hash = "sha256-VD8l1dPzYB5ccCdo563mnAtZ0DWPiT3zY40vRJnmlgs=";
      };
    })
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
    otter-nvim
    plenary-nvim
    undotree
  ];

  startPlugins = tsParsers ++ colorthemes ++ plugins;

  packageName = "nix-vimrc-hcfg";
  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}
    ln -vsfT ${./hcfg} $out/pack/${packageName}/start/hcfg

    mkdir -p $out/pack/${packageName}/start/hcfg-extra/lua
    cat << EOF >"$out/pack/${packageName}/start/hcfg-extra/lua/hcfg-extra.lua"
    ${extraLuaConfig}
    EOF

    mkdir -p $out/pack/${packageName}/start/hcfg-pre/lua
    cat << EOF >"$out/pack/${packageName}/start/hcfg-pre/lua/hcfg-pre.lua"
    ${extraLuaPreConfig}
    EOF
    
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
  pname = "nvim";
  inherit version;
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
  meta = {
    description = "handdara nix-wrapped and configured neovim";
    homepage = "https://github.com/handdara/nix-vimrc";
    mainProgram = "nvim";
  };
}
