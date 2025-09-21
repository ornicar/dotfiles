{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    cargo
    cargo-watch
    rustc
    rust-analyzer
  ];
}
