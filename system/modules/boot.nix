{ pkgs, ... }: {

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
      "vm.dirty_writeback_centisecs" = "2500";
      # https://www.techtarget.com/searchdatacenter/definition/Linux-swappiness
      # default was 60
      "vm.swappiness" = "30";
    };
    kernelParams = [ "nmi_watchdog=0" ];
  };
}
