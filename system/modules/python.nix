{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (python3.withPackages (ps:
        with ps; [
          requests
          gitpython
          tldextract
          dns
          httpx
          h2
          websocket-client
        ]))
    ];
}
