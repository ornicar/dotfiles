{ pkgs, ... }:

{
  # https://wiki.archlinux.org/title/AMDGPU#Boot_parameter
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfff7ffff" ];

  systemd.services.thib-amdgpu-set-power = {
    script = let drm-dir = "/sys/class/drm/card1/device";
    in ''
      ${pkgs.coreutils}/bin/echo "manual" > ${drm-dir}/power_dpm_force_performance_level
      ${pkgs.coreutils}/bin/echo "2" > ${drm-dir}/pp_power_profile_mode
    '';
    serviceConfig = {
      Description = "Sets AMDGPU power profile to POWER_SAVING";
      Type = "oneshot";
      User = "root";
    };
  };

  systemd.timers.thib-amdgpu-set-power = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/5"; # every 5 minutes
      Unit = "thib-amdgpu-set-power.service";
    };
  };
}
