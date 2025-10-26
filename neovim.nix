{
  lib,
  makeWrapper,
  neovim-unwrapped,
  runCommandLocal,
  symlinkJoin,
  version,
  vimPlugins,
}:
let

  startPlugins = [
    vimPlugins.fzf-lua
    vimPlugins.mini-files
    vimPlugins.nvim-surround
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.nvim-web-devicons
    vimPlugins.obsidian-nvim
    vimPlugins.undotree
    # colorthemes
    vimPlugins.eva01-vim
    vimPlugins.rose-pine
    vimPlugins.vim-paper
    vimPlugins.boo-colorscheme-nvim
  ];

  packageName = "nix-neovimrc";
  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}
    ln -vsfT ${./hcfg} $out/pack/${packageName}/start/hcfg
    ${lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
    ) startPlugins}
  '';

in
symlinkJoin {
  name = "nvim";
  paths = [ neovim-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --add-flags '-u' \
      --add-flags '${./vimrc}' \
      --add-flags '--cmd' \
      --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
      --set-default NVIM_APPNAME nvim-custom
  '';
  passthru = {
    inherit packpath;
  };
}
