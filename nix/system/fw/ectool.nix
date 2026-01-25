{ pkgs, ... }:
{

  environment.systemPackages = [ pkgs.fw-ectool ];

  systemd.services.thib-ectool-monitor = {
    description = "Read fan RPM from ectool and write to /tmp/ectool-fan-rpm";
    wantedBy = [ "multi-user.target" ];
    script =
      let
        sed = "${pkgs.gnused}/bin/sed";
        ectool = "${pkgs.fw-ectool}/bin/ectool";
      in
      ''
        while :
        do
          rpm1=$(${ectool} pwmgetfanrpm | ${sed} -rn 's/Fan 0 RPM: ([0-9]+)/\1/p')
          rpm2=$(${ectool} pwmgetfanrpm | ${sed} -rn 's/Fan 1 RPM: ([0-9]+)/\1/p')
          echo "$rpm1 $rpm2" > /tmp/ectool-fan-rpm
          sleep 2
        done
      '';
  };
}
