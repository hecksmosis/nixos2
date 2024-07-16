{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$scrPath" = "~/nixos/home-manager/modules/wms/scripts";

      # big pc conf, change for laptop
      monitor = "HDMI-A-2,preferred,0x0,auto"
      monitor = "HDMI-A-1,preferred,0x1080,auto"

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,36"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,~/screens"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "MOZ_ENABLE_WAYLAND,1"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__GL_VRR_ALLOWED,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "es";
        follow_mouse = 1;

        touchpad = {
            natural_scroll = "no";
        }

        sensitivity = 1.0; # -1.0 - 1.0, 0 means no modification.
        force_no_accel = 1;
      }

      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";

        layout = "dwindle";
        resize_on_border = true;
      };

      group = {
        "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };

      decoration = {
        rounding = 10;
        dim_special = 0.3;

        blur = {
          special = true;
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };

        drop_shadow = false;
      };

      layerrule = "blur,waybar";

      animations = {
        enabled = true;

        bezier = "wind, 0.05, 0.9, 0.1, 1.05";
        bezier = "winIn, 0.1, 1.1, 0.1, 1.1";
        bezier = "winOut, 0.3, -0.3, 0, 1";
        bezier = "liner, 1, 1, 1, 1";

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        pseudotile = true; 
        preserve_split = true; 
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = false;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      misc = {
        vrr = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      windowrule = [
        "float, ^(imv)$"
        "float, ^(mpv)$"
      ];

      exec-once = [
        "swww init"
        "swww img ~/Downloads/nixos-chan.png"
        "dunst"
        "waybar"
        "blueman-applet"
        "nm-applet --indicator"
        "swaylock"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "$scrPath/batterynotify.sh"
      ];

      exec = [
        "hyprctl setcursor Bibata-Modern-Ice 20"
        "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'"
        "gsettings set org.gnome.desktop.interface cursor-size 20"
        "gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'"
        "gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'"
        "gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font Mono 9'"
        "gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'"
        "gsettings set org.gnome.desktop.interface font-hinting 'full'"
        "gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-dracula'"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha'"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
      ]

      bind = [
        "ALT, F4, killactive,"
        "ALT, return, fullscreen,"

        "$CONTROL, ESCAPE, exec, killall waybar || waybar"
        "$CONTROL SHIFT, ESCAPE, exec, $scrPath/sysmonlaunch.sh"

        "$mainMod, backspace, exec, $scrPath/logoutlaunch.sh 1"
        "$mainMod, delete, exit,"
        "$mainMod, W, killactive,"
        "$mainMod, Q, exec, alacritty"
        "$mainMod, N, exec, swaylock"
        "$mainMod, E, exec, dolphin"
        "$mainMod, F, exec, calibre"
        "$mainMod, C, exec, firefox"
        "$mainMod, D, exec, alacritty nvim"
        "$mainMod, B, togglefloating,"
        "$mainMod, G, togglegroup,"
        "$mainMod, U, togglesplit, # dwindle"

        "$mainMod, A, exec, pkill -x rofi || $scrPath/rofilaunch.sh d"
        "$mainMod, tab, exec, pkill -x rofi || $scrPath/rofilaunch.sh w"
        "$mainMod, R, exec, pkill -x rofi || $scrPath/rofilaunch.sh f"

        "$mainMod, P, exec, $scrPath/screenshot.sh s" 
        "$mainMod CTRL, P, exec, $scrPath/screenshot.sh sf" 
        "$mainMod ALT, P, exec, $scrPath/screenshot.sh m" 
        ",print, exec, $scrPath/screenshot.sh p  "

        "$mainMod, V, exec, pkill -x rofi || $scrPath/cliphist.sh c  "
        "$mainMod, Ñ, exec, $scrPath/keyboardswitch.sh "

        "$mainMod, H, movefocus, l"
        "$mainMod, left, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, right, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, up, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod, down, movefocus, d"
        "ALT, Tab, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod CTRL, L, workspace, r+1 "
        "$mainMod CTRL, right, workspace, r+1 "
        "$mainMod CTRL, H, workspace, r-1"
        "$mainMod CTRL, left, workspace, r-1"
        "$mainMod CTRL, down, workspace, empty "

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod CTRL ALT, L, movetoworkspace, r+1"
        "$mainMod CTRL ALT, right, movetoworkspace, r+1"
        "$mainMod CTRL ALT, H, movetoworkspace, r-1"
        "$mainMod CTRL ALT, left, movetoworkspace, r-1"

        "$mainMod SHIFT $CONTROL, H, movewindow, l"
        "$mainMod SHIFT $CONTROL, left, movewindow, l"
        "$mainMod SHIFT $CONTROL, L, movewindow, r"
        "$mainMod SHIFT $CONTROL, right, movewindow, r"
        "$mainMod SHIFT $CONTROL, K, movewindow, u"
        "$mainMod SHIFT $CONTROL, up, movewindow, u"
        "$mainMod SHIFT $CONTROL, J, movewindow, d"
        "$mainMod SHIFT $CONTROL, down, movewindow, d"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod ALT, S, movetoworkspacesilent, special"
        "$mainMod, S, togglespecialworkspace,"

        "$mainMod ALT, 1, movetoworkspacesilent, 1"
        "$mainMod ALT, 2, movetoworkspacesilent, 2"
        "$mainMod ALT, 3, movetoworkspacesilent, 3"
        "$mainMod ALT, 4, movetoworkspacesilent, 4"
        "$mainMod ALT, 5, movetoworkspacesilent, 5"
        "$mainMod ALT, 6, movetoworkspacesilent, 6"
        "$mainMod ALT, 7, movetoworkspacesilent, 7"
        "$mainMod ALT, 8, movetoworkspacesilent, 8"
        "$mainMod ALT, 9, movetoworkspacesilent, 9"
        "$mainMod ALT, 0, movetoworkspacesilent, 10"

        # Configuration files
        ''$mainMod SHIFT, N, exec, alacritty -e sh -c "rb"''
        ''$mainMod SHIFT, C, exec, alacritty -e sh -c "conf"''
        ''$mainMod SHIFT, Q, exec, alacritty -e sh -c "nvim ~/nixos/home-manager/modules/wms/hyprland.nix"''
        ''$mainMod SHIFT, W, exec, alacritty -e sh -c "nvim ~/nixos/home-manager/modules/wms/waybar.nix''

        # Disable all effects
        "$mainMod ALT, G, exec, $scrPath/gamemode.sh"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ", F10, exec, $scrPath/volumecontrol.sh -o m"
        ", XF86AudioMute, exec, $scrPath/volumecontrol.sh -o m"
        ", XF86AudioMicMute, exec, $scrPath/volumecontrol.sh -i m" 
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      binde = [
        "$mainMod SHIFT, L, resizeactive, 30 0"
        "$mainMod SHIFT, right, resizeactive, 30 0"
        "$mainMod SHIFT, H, resizeactive, -30 0"
        "$mainMod SHIFT, left, resizeactive, -30 0"
        "$mainMod SHIFT, K, resizeactive, 0 -30"
        "$mainMod SHIFT, up, resizeactive, 0 -30"
        "$mainMod SHIFT, J, resizeactive, 0 30"
        "$mainMod SHIFT, down, resizeactive, 0 30"

        "$mainMod ALT, L, swapwindow, r"
        "$mainMod ALT, right, swapwindow, r "
        "$mainMod ALT, H, swapwindow, l"
        "$mainMod ALT, left, swapwindow, l"
        "$mainMod ALT, K, swapwindow, u "
        "$mainMod ALT, up, swapwindow, u"
        "$mainMod ALT, J, swapwindow, d"
        "$mainMod ALT, down, swapwindow, d"
      ]

      bindel = [
        ", F11, exec, $scrPath/volumecontrol.sh -o d"
        ", F12, exec, $scrPath/volumecontrol.sh -o i"
        ", XF86AudioLowerVolume, exec, $scrPath/volumecontrol.sh -o d"
        ", XF86AudioRaiseVolume, exec, $scrPath/volumecontrol.sh -o i"
        ", XF86MonBrightnessUp, exec, $scrPath/brightnesscontrol.sh i"
        ", XF86MonBrightnessDown, exec, $scrPath/brightnesscontrol.sh d"
      ];
    };
  };
}
