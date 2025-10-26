.PHONY: build format list packpath run_from_git

build:
	nix build .#neovim

list:
	grep '^\w*:' makefile | xargs -n1 echo '->'

format:
	nix-shell -p nixfmt-rfc-style --run "fd -e nix -x nixfmt"

run:
	nix run .#neovim

packpath:
	nix build .#neovim.packpath

run_from_git:
	nix run github:handdara/nix-vimrc --refresh
