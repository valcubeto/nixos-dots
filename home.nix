{ config, pkgs, ... }:
{
  home.username = "cubeto";
  home.homeDirectory = "/home/cubeto";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    zed-editor
  ];

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        hello = "echo hello, nixos!";
      };
      # profileExtra = ''
      #   if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #     start-hyprland
      #   fi
      # '';
    };
    kitty = {
      enable = true;
      font.name = "JetBrains Mono Nerd Font";
      font.size = 12;
    };
  };
}
