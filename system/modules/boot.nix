{ pkgs, ... }: {

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = { "fs.inotify.max_user_watches" = "1048576"; };
  };
}
