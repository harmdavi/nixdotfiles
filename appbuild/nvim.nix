{ pkgs }:

pkgs.neovim-unwrapped.overrideAttrs (old: {
  pname = "neovim-git";

  src = pkgs.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";

    rev = "release-0.12";

    # temporary hash; Nix will tell you the real one
    hash = "sha256-lr1xYmGOjF3uZ6In26RTAFfITxHYHVhF5GQS68KhyrE=";
  };
  doInstallCheck = false;
})
