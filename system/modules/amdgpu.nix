{ pkgs, ... }:

{
  # https://wiki.archlinux.org/title/AMDGPU#Boot_parameter
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfff7ffff" ];

  environment.systemPackages = with pkgs; [ lact ];

  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
    enable = true;
  };

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
  #
  # systemd.services.thib-amdgpu = {
  #   description = "AMDGPU Thib's monitoring";
  #   after = [ "multi-user.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     ExecStart = let
  #       device = "amdgpu-pci-0800";
  #       write-dir = "/tmp";
  #       sensors = "${pkgs.lm_sensors}/bin/sensors";
  #       sed = "${pkgs.gnused}/bin/sed";
  #     in pkgs.writeShellScript "thib-amdgpu" ''
  #       while :
  #       do
  #         sens=$(${sensors} ${device})
  #         echo $sens | ${sed} -rn 's/.*PPT:\s+([0-9]+).*/\1/p' > ${write-dir}/gpu-power
  #         echo $sens | ${sed} -rn 's/.*edge:\s+.([0-9]+).*/\1/p' > ${write-dir}/gpu-temp
  #         sleep 1
  #       done
  #     '';
  #   };
  #   enable = true;
  # };
}
