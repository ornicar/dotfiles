{ lib, ... }: {

  # allow reading assets from home
  users.users.nginx.extraGroups = [ "users" ];
  systemd.services.nginx.serviceConfig.ProtectHome = "read-only";

  networking.extraHosts = ''
    127.0.0.1 recipes.local
  '';

  services.nginx = {
    commonHttpConfig = lib.mkAfter ''

      upstream recipes {
        server 127.0.0.1:9801;
      }
    '';

    virtualHosts = let
      listenLocal80 = {
        addr = "0.0.0.0";
        port = 80;
      };
      # listenLocal443 = {
      #   addr = "0.0.0.0";
      #   port = 443;
      #   ssl = true;
      # };
      # listenLocal = [ listenLocal443 listenLocal80 ];
      listenLocal = [ listenLocal80 ];
    in {
      "recipes.local" = let
        proxyConf = ''
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_http_version 1.1;'';
      in {
        listen = listenLocal;
        enableACME = false;
        forceSSL = false;
        extraConfig = ''

          # ssl_certificate /etc/ssl/certs/l.org.crt;
          # ssl_certificate_key /etc/ssl/private/l.org.key;

          location / {
            ${proxyConf}
            proxy_pass http://recipes;  # no trailing /
          }
        '';
      };
    };
  };
}
