{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ pavucontrol ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
