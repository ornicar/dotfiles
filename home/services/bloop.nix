{ pkgs, lib, config, ... }: {
  systemd.user.services.bloop = {
    Unit = { Description = "Bloop Scala build server"; };
    Service = {
      Environment = [
        "PATH=${lib.makeBinPath [ config.programs.java.package ]}"
        ''
          JAVA_OPTS="-Xms4g -Xmx14G -XX:+UseG1GC -Xss2m -XX:InitialCodeCacheSize=512m -XX:ReservedCodeCacheSize=512m"''
      ];
      ExecStart = "${pkgs.bloop}/bin/bloop server";
      ExecStop = "${pkgs.psmisc}/bin/fuser -k 8212/tcp -TERM";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
