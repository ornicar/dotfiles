{ lib, ... }: {

  networking.extraHosts = ''
    127.0.0.1 l.org l1.org socket.l.org
  '';

  # allow reading assets from home
  users.users.nginx.extraGroups = [ "users" ];
  systemd.services.nginx.serviceConfig.ProtectHome = "read-only";

  services.nginx = {
    commonHttpConfig = lib.mkAfter ''

      upstream lila {
        server 127.0.0.1:9663;
      }

      log_format log_format_sample '$remote_addr - $remote_user [$time_local] '
                            '"$request" $status $body_bytes_sent '
                            '"$http_referer" "$http_user_agent"';

      log_format log_format_rate_limit '$remote_addr'; # extremely simplified ratelimit log lines

      geo $limited {
        default 0;
        127.0.0.1 0;
      }

      geo $ip_tier {
        default 1;
        127.0.0.1 2;
      }

      map $limited $limit {
        1 $binary_remote_addr;
        0 "";
      }

      # access log sampling, see https://www.nginx.com/blog/sampling-requests-with-nginx-conditional-logging/
      split_clients $request_id $log_sample_access {
        1% 1;
        *  0;
      }
      split_clients $request_id $log_sample_rate_limit {
        10% 1;
        *   0;
      }

      map $status $rate_limited {
        default 0;
        429     $log_sample_rate_limit; # sample rate limit logs
      }

      limit_req_zone $limit zone=all:4m rate=5000r/m;
    '';

    virtualHosts = let
      # listenLocal80 = [{
      #   addr = "0.0.0.0";
      #   port = 80;
      # }];
      listenLocal443 = [{
        addr = "0.0.0.0";
        port = 443;
        ssl = true;
      }];
      listenLocal = listenLocal443;
    in {
      #       "lichess-assets.local" = {
      #         listen = [ { addr = "0.0.0.0"; port = 80; } { addr = "0.0.0.0"; port = 443; ssl = true; } ];
      #         extraConfig = ''
      # location /assets/ {                                                                                                                                                          
      #   add_header "Access-Control-Allow-Origin" "*";                                                                                                                             
      #   alias /home/thib/lila/public;                                                                                                                                             
      # }                                                                                                                                                                           
      # '';
      #       };
      "l.org" = let
        lichessProxyConf = ''
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_http_version 1.1;'';
      in {
        listen = listenLocal;
        enableACME = false;
        forceSSL = false;
        extraConfig = ''

          ssl_certificate /etc/ssl/certs/l.org.crt;
          ssl_certificate_key /etc/ssl/private/l.org.key;

          error_log /var/log/nginx/lila.error.log;
          access_log /var/log/nginx/lila.access.log log_format_sample if=$log_sample_access;

          limit_req_log_level warn; # put rate limit logs in a distinct file, not in the error log
          access_log /var/log/nginx/rate_limited.log log_format_rate_limit if=$log_sample_rate_limit;

          error_page 501 /oops/disabled.html;
          error_page 500 501 502 503 /oops/servererror.html;
          error_page 504 /oops/timeout.html;
          error_page 429 /oops/toomanyrequests.html;
          location /oops/ {
            root /home/thib/lila/public/;
          }

          location = /favicon.ico {
            alias /home/thib/lila/public/favicon.ico;
          }
          location /assets/lifat/ {
            autoindex on;
            access_log /var/log/nginx/access.log;
            add_header Cache-Control public;
            add_header Access-Control-Allow-Origin "*" always; # for vosk
            add_header Cross-Origin-Resource-Policy "cross-origin" always;
            alias /home/thib/lifat/;
          }
          location /assets/ {
            rewrite "^/assets/_\w{6}/(.+)$" /assets/$1;
            add_header Service-Worker-Allowed "/";
            add_header Cross-Origin-Embedder-Policy "require-corp"; # for stockfish
            alias /home/thib/lila/public/;
          # proxy_pass http://lila;  # no trailing /
          }
          location /game/export/ {
            access_log /var/log/nginx/lichess.image.log;
            proxy_http_version 1.1;
            proxy_pass http://lila/game/export/;
          }
          location /image/ {
            expires 6M;
            access_log /var/log/nginx/lichess.image.log;
            proxy_http_version 1.1;
            proxy_pass http://lila/image/;
          }

          #location = /games/search {
          #return 501;
          #}

          location /statlog {
            access_log /var/log/nginx/lila.stat.log;
            return 204;
          }
          location = /manifest.json {
            proxy_cache static_pages;
            proxy_cache_valid 200 10m;
            proxy_pass http://lila;
          }

          location /api/stream {
            ${lichessProxyConf}
            access_log /var/log/nginx/lila.stream.log;
            proxy_read_timeout 3h;
            proxy_pass http://lila/api/stream;
          }

          location /upload {
            ${lichessProxyConf}
            access_log /var/log/nginx/lichess.access.log;
            client_max_body_size 6M;
            proxy_read_timeout 60s;
            proxy_pass http://lila;
          }

          location = /login {
            ${lichessProxyConf}
            proxy_set_header X-Ip-Tier $ip_tier;
            proxy_pass http://lila;
          }

          # location /insights/ {
          #   ${lichessProxyConf}
          #   return 501;
          #   # proxy_pass http://lila/temporarily-disabled/;
          # }

          location ~ ^/opening/ {
            ${lichessProxyConf}
            rewrite ^(.+)["/)\]]$ $1 permanent;
            limit_req zone=all burst=20 nodelay;
            proxy_pass http://lila;  # no trailing /
          }

          location / {
            ${lichessProxyConf}
            #limit_req zone=nodos_base_tier1 burst=50 nodelay;
            #limit_req zone=nodos_base_tier2 burst=150 nodelay;
            limit_req zone=all burst=20 nodelay;
            proxy_pass http://lila;  # no trailing /
          }
        '';
      };
      "socket.l.org" = {
        enableACME = false;
        forceSSL = false;
        listen = listenLocal;
        extraConfig = ''

          ssl_certificate /etc/ssl/certs/socket.l.org.crt;
          ssl_certificate_key /etc/ssl/private/socket.l.org.key;

          if ( $request_method !~ GET ) {
            return 405;
          }

          location / {
            proxy_http_version 1.1;
            proxy_set_header Host $host;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $http_connection;
            proxy_set_header X-Forwarded-For $remote_addr;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_pass http://127.0.0.1:9664;  # no trailing /
          }
        '';
      };
    };
  };
}
