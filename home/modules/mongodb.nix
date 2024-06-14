{ ... }: {
  home.file.".mongoshrc".text = # js
    ''
      const sec = () => connect('mongodb://localhost:27117/lichess');
    '';
}
