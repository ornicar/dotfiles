{ pkgs, ... }: {

  environment.systemPackages = [ pkgs.fw-ectool ];

  systemd.services.thib-ectool-monitor = {
    script = let
      sed = "${pkgs.gnused}/bin/sed";
      ectool = "${pkgs.fw-ectool}/bin/ectool";
    in ''
      while :
      do
        rpm=$(${ectool} pwmgetfanrpm | ${sed} -rn 's/Fan 0 RPM: ([0-9]+)/\1/p')
        echo $rpm > /tmp/ectool-fan-rpm
        sleep 2
      done
    '';
  };
}
