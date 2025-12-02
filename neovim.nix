{
  fetchFromGitHub,
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
    asm         gnuplot  perl
    awk         haskell  python
    bibtex      html     r
    cmake       ini      regex
    cpp         jq       rust
    css         json     sql
    csv         just     supercollider
    fish        kdl      tcl
    fortran     latex    tmux
    gitcommit   luadoc   typst
    gitignore   make     yaml
    git_rebase  nix      zig
  ];
  
  colorthemes = with vimPlugins; [ 
    eva01-vim
    rose-pine
    vim-paper
    boo-colorscheme-nvim
    lackluster-nvim
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
    (vimUtils.buildVimPlugin {
      name = "vim-tidal";
      src = fetchFromGitHub {
        owner = "tidalcycles";
        repo = "vim-tidal";
        rev = "e440fe5bdfe07f805e21e6872099685d38e8b761";
        hash = "sha256-8gyk17YLeKpLpz3LRtxiwbpsIbZka9bb63nK5/9IUoA=";
      };
    })
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
