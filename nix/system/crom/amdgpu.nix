{ pkgs, ... }: {

  systemd.services.thib-amdgpu-monitor = {
    script = let
      device = "amdgpu-pci-0300";
      sensors = "${pkgs.lm_sensors}/bin/sensors";
      sed = "${pkgs.gnused}/bin/sed";
    in ''
      while :
      do
        sens=$(${sensors} ${device})
        power=$(echo $sens | ${sed} -rn 's/.*PPT:\s+([0-9]+).*/\1/p')
        echo $power > /tmp/gpu-power
        echo $sens | ${sed} -rn 's/.*edge:\s+.([0-9]+).*/\1/p' > /tmp/gpu-temp
        sleep 1
      done
    '';
  };

  # https://wiki.archlinux.org/title/AMDGPU#Boot_parameter
  # boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ];
  #
  # systemd.services.thib-amdgpu-set-power = {
  #   script = let drm-dir = "/sys/class/drm/card1/device";
  #   in ''
  #     ${pkgs.coreutils}/bin/echo "manual" > ${drm-dir}/power_dpm_force_performance_level
  #     ${pkgs.coreutils}/bin/echo "2" > ${drm-dir}/pp_power_profile_mode
  #   '';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #   };
  # };

  # systemd.timers.thib-amdgpu-set-power = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnCalendar = "*:0/5"; # every 5 minutes
  #     Unit = "thib-amdgpu-set-power.service";
  #   };
  # };
}
