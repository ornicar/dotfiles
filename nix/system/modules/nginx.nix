{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ nginx ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "t@lichess.org";
  };

  services.nginx = {
    enable = true;
    enableReload = true;
    commonHttpConfig = ''

      proxy_cache_path /tmp/nginx-cache keys_zone=static_pages:2m;
    '';
  };
}
