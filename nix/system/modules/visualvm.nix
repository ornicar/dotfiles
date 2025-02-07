{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ visualvm ];

  # https://github.com/oracle/visualvm/issues/403#issuecomment-1152895277
  environment.sessionVariables = { _JAVA_AWT_WM_NONREPARENTING = 1; };
}
