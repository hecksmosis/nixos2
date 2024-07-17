{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;

      font = {
        size = 11.0;
        normal = {
          family = "JetBrains Mono";
          style = "Bold";
        };
      };

      colors.primary.background = "#1d2021";
    };
  };
}
