{ pkgs }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "tree-sitter-cli";
  version = "0.26.8";

  src = pkgs.fetchFromGitHub {
    owner = "tree-sitter";
    repo = "tree-sitter";
    rev = "v${version}";
    hash = "sha256-fcFEfoALrbpBD6rWogxJ7FNVlvDQgswoX9ylRgko+8Q=";
  };

  cargoHash = "sha256-9FeWnWWPUWmMF15Psmul8GxGv2JceHWc2WZPmOr81gw=";

  nativeBuildInputs = with pkgs; [
    pkg-config
    clang
    llvmPackages.clang
  ];

  buildInputs = with pkgs; [
    llvmPackages.libclang
  ];

  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";

  BINDGEN_EXTRA_CLANG_ARGS = ''
    -I${pkgs.llvmPackages.libclang.lib}/lib/clang
    -I${pkgs.llvmPackages.libclang.dev}/include
  '';

  CLANG_PATH = "${pkgs.llvmPackages.clang}/bin/clang";

  doCheck = false;
}
