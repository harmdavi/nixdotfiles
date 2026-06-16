{ pkgs }:

pkgs.neovim-unwrapped.overrideAttrs (old: {
  pname = "neovim-git";

  src = pkgs.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";

    rev = "release-0.12";
    # temporary hash; Nix will tell you the real one
    hash = "sha256-ASYBTHAxSEb1va4ljeWVW6RaVNPKNhxk0Y6Vu7XkuFU=";
  };
  doInstallCheck = false;
})
