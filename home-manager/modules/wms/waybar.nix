{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        height = 21;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;

        modules-left = ["custom/padd" "custom/l_end" "hyprland/workspaces" "hyprland/window" "custom/r_end" "custom/padd"];
        modules-center = ["custom/padd" "custom/l_end" "idle_inhibitor" "clock" "custom/r_end" "custom/padd"];
        modules-right = ["custom/padd" "custom/l_end" "cpu" "memory" "custom/gpuinfo" "custom/r_end" "custom/l_end" "backlight" "network" "bluetooth" "pulseaudio" "pulseaudio#microphone" "custom/updates" "custom/r_end" "custom/l_end" "tray" "battery" "custom/r_end" "custom/l_end" "custom/wallchange" "custom/mode" "custom/wbar" "custom/cliphist" "custom/power" "custom/r_end" "custom/padd"];

    "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        active-only = false;
        on-click= "activate";
        persistent-workspaces= {
        };
    };

    "hyprland/window"= {
        format= "  {}";
        separate-outputs= true;
        rewrite= {
            "hecksmosis@heckserver:(.*)"= "$1 ";
            "(.*) — Mozilla Firefox"= "$1 󰈹";
            "(.*)Mozilla Firefox"= "Firefox 󰈹";
            "(.*) - Visual Studio Code"= "$1 󰨞";
            "(.*)Visual Studio Code"= "Code 󰨞";
            "(.*) — Dolphin"= "$1 󰉋";
            "(.*)Spotify"= "Spotify 󰓇";
            "(.*)Steam"= "Steam 󰓓";
        };
        max-length= 1000;
    };

    idle_inhibitor= {
        format= "{icon}";
        format-icons= {
            activated= "󰥔";
            deactivated= "";
        };
    };

    "clock"= {
        format= "{:%R 󰃭 %d·%m·%y}";
        format-alt= "{:%I:%M %p}";
        tooltip-format= "<tt>{calendar}</tt>";
        calendar= {
            mode= "month";
            mode-mon-col= 3;
            on-scroll= 1;
            on-click-right= "mode";
            format= {
                months= "<span color='#ffead3'><b>{}</b></span>";
                weekdays= "<span color='#ffcc66'><b>{}</b></span>";
                today= "<span color='#ff6699'><b>{}</b></span>";
            };
        };
        actions= {
            on-click-right= "mode";
            on-click-forward= "tz_up";
            on-click-backward= "tz_down";
            on-scroll-up= "shift_up";
            on-scroll-down= "shift_down";
        };
    };

    cpu= {
        interval= 10;
        format= "󰍛 {usage}%";
        format-alt= "{icon0}{icon1}{icon2}{icon3}";
        format-icons= ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    };

    memory= {
        interval= 30;
        format= "󰾆 {percentage}%";
        format-alt= "󰾅 {used}GB";
        max-length= 10;
        tooltip= true;
        tooltip-format= " {used:0.1f}GB/{total:0.1f}GB";
    };

    "custom/gpuinfo"= {
        exec= " ./scripts/gpuinfo.sh";
        return-type= "json";
        format= " {}";
        interval= 5;
        tooltip= true;
        max-length= 1000;
        on-click= "./scripts/gpuinfo.sh --toggle";
    };

    "custom/gpuinfo#nvidia"= {
        exec= " ./scripts/gpuinfo.sh --use nvidia ";
        return-type= "json";
        format= " {}";
        interval= 5;
        tooltip= true;
        max-length= 1000;
    };

    "custom/gpuinfo#amd"= {
        exec= " ./scripts/gpuinfo.sh --use amd ";
        return-type= "json";
        format= " {}";
        interval= 5;
        tooltip= true;
        max-length= 1000;
    };

    "custom/gpuinfo#intel"= {
        exec= " ./scripts/gpuinfo.sh --use intel ";
        return-type= "json";
        format= " {}";
        interval= 5;
        tooltip= true;
        max-length= 1000;
    };

    backlight= {
        device= "intel_backlight";
        format= "{icon} {percent}%";
        format-icons= ["" "" "" "" "" "" "" "" ""];
        on-scroll-up= "brightnessctl set 1%+";
        on-scroll-down= "brightnessctl set 1%-";
        min-length= 6;
    };

    network= {
        tooltip= true;
        format-wifi= " ";
        format-ethernet= "󰈀 ";
        tooltip-format= "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
        format-linked= "󰈀 {ifname} (No IP)";
        format-disconnected= "󰖪 ";
        tooltip-format-disconnected= "Disconnected";
        format-alt= "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
        interval= 2;
    };

    bluetooth= {
        format= "";
        format-disabled= "";
        format-connected= " {num_connections}";
        format-connected-battery= "{icon} {num_connections}";
        format-icons= ["󰥇" "󰤾" "󰤿" "󰥀" "󰥁" "󰥂" "󰥃" "󰥄" "󰥅" "󰥆" "󰥈"];
        tooltip-format= "{controller_alias}\n{num_connections} connected";
        tooltip-format-connected= "{controller_alias}\n{num_connections} connected\n\n{device_enumerate}";
        tooltip-format-enumerate-connected= "{device_alias}";
        tooltip-format-enumerate-connected-battery= "{device_alias}\t{icon} {device_battery_percentage}%";
    };

    pulseaudio= {
        format= "{icon} {volume}";
        format-muted= "婢";
        on-click= "pavucontrol -t 3";
        on-click-middle= "./scripts/volumecontrol.sh -o m";
        on-scroll-up= "./scripts/volumecontrol.sh -o i";
        on-scroll-down= "./scripts/volumecontrol.sh -o d";
        tooltip-format= "{icon} {desc} // {volume}%";
        scroll-step= 5;
        format-icons= {
            headphone= "";
            hands-free= "";
            headset= "";
            phone= "";
            portable= "";
            car= "";
            default= ["" "" ""];
        };
    };

    "pulseaudio#microphone"= {
        format= "{format_source}";
        format-source= "";
        format-source-muted= "";
        on-click= "pavucontrol -t 4";
        on-click-middle= "./scripts/volumecontrol.sh -i m";
        on-scroll-up= "./scripts/volumecontrol.sh -i i";
        on-scroll-down= "./scripts/volumecontrol.sh -i d";
        tooltip-format= "{format_source} {source_desc} // {source_volume}%";
        scroll-step= 5;
    };

    "custom/updates"= {
        exec= "./scripts/systemupdate.sh";
        return-type= "json";
        format= "󰮯 {}";
        on-click= "./scripts/systemupdate.sh up";
        interval= 86400;
        tooltip= true;
    };

    tray= {
        icon-size= 12;
        spacing= 5;
    };

    battery= {
        states= {
            good= 95;
            warning= 30;
            critical= 2;
        };
        format= "{icon} {capacity}%";
        format-charging= " {capacity}%";
        format-plugged= " {capacity}%";
        format-alt= "{time} {icon}";
        format-icons= ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    };

    "custom/cliphist"= {
        format= "{}";
        exec= "echo ; echo 󰅇 clipboard history";
        on-click= "sleep 0.1 && ./scripts/cliphist.sh c";
        on-click-right= "sleep 0.1 && ./scripts/cliphist.sh d";
        on-click-middle= "sleep 0.1 && ./scripts/cliphist.sh w";
        interval = 86400;
        tooltip= true;
    };

    "custom/power"= {
        format= "{}";
        exec= "echo ; echo  logout";
        on-click= "./scripts/logoutlaunch.sh 2";
        interval = 86400;
        tooltip= true;
    };

    "custom/l_end"= {
        format= " ";
        interval = "once";
        tooltip= false;
    };

    "custom/r_end"= {
        format= " ";
        interval = "once";
        tooltip= false;
    };

    "custom/sl_end"= {
        format= " ";
        interval = "once";
        tooltip= false;
    };

    "custom/sr_end"= {
        format= " ";
        interval = "once";
        tooltip= false;
    };

    "custom/rl_end"= {
        format= " ";
        interval = "once";
        tooltip= false;
    };

    "custom/rr_end"= {
        format= " ";
        interval = "once";
        tooltip= false;
    };

    "custom/padd"= {
        format= "  ";
        interval = "once";
        tooltip= false;
    };

      };
    };
  
    style = 
      ''
* {
    border: none;
    border-radius: 0px;
    font-family: "JetBrainsMono Nerd Font";
    font-weight: bold;
    font-size: 12px;
    min-height: 10px;
}

@define-color bar-bg rgba(0, 0, 0, 0);

@define-color main-bg #11111b;
@define-color main-fg #cdd6f4;

@define-color wb-act-bg #a6adc8;
@define-color wb-act-fg #313244;

@define-color wb-hvr-bg #f5c2e7;
@define-color wb-hvr-fg #313244;

window#waybar {
    background: @bar-bg;
}

tooltip {
    background: @main-bg;
    color: @main-fg;
    border-radius: 8px;
    border-width: 0px;
}

#workspaces button {
    box-shadow: none;
	text-shadow: none;
    padding: 0px;
    border-radius: 9px;
    margin-top: 3px;
    margin-bottom: 3px;
    margin-left: 0px;
    padding-left: 3px;
    padding-right: 3px;
    margin-right: 0px;
    color: @main-fg;
    animation: ws_normal 20s ease-in-out 1;
}

#workspaces button.active {
    background: @wb-act-bg;
    color: @wb-act-fg;
    margin-left: 3px;
    padding-left: 12px;
    padding-right: 12px;
    margin-right: 3px;
    animation: ws_active 20s ease-in-out 1;
    transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
}

#workspaces button:hover {
    background: @wb-hvr-bg;
    color: @wb-hvr-fg;
    animation: ws_hover 20s ease-in-out 1;
    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
}

#taskbar button {
    box-shadow: none;
	text-shadow: none;
    padding: 0px;
    border-radius: 9px;
    margin-top: 3px;
    margin-bottom: 3px;
    margin-left: 0px;
    padding-left: 3px;
    padding-right: 3px;
    margin-right: 0px;
    color: @wb-color;
    animation: tb_normal 30s ease-in-out 1;
}

#taskbar button.active {
    background: @wb-act-bg;
    color: @wb-act-color;
    margin-left: 3px;
    padding-left: 12px;
    padding-right: 12px;
    margin-right: 3px;
    animation: tb_active 30s ease-in-out 1;
    transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
}

#taskbar button:hover {
    background: @wb-hvr-bg;
    color: @wb-hvr-color;
    animation: tb_hover 30s ease-in-out 1;
    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
}

#backlight,
#battery,
#bluetooth,
#custom-cliphist,
#clock,
#cpu,
#custom-gpuinfo,
#idle_inhibitor,
#language,
#memory,
#custom-mode,
#mpris,
#network,
#custom-power,
#pulseaudio,
#custom-spotify,
#taskbar,
#tray,
#custom-updates,
#custom-wallchange,
#custom-wbar,
#window,
#workspaces,
#custom-l_end,
#custom-r_end,
#custom-sl_end,
#custom-sr_end,
#custom-rl_end,
#custom-rr_end {
    color: @main-fg;
    background: @main-bg;
    opacity: 1;
    margin: 4px 0px 4px 0px;
    padding-left: 4px;
    padding-right: 4px;
}

#workspaces,
#taskbar {
    padding: 0px;
}

#custom-r_end {
    border-radius: 0px 22px 22px 0px;
    margin-right: 9px;
    padding-right: 3px;
}

#custom-l_end {
    border-radius: 22px 0px 0px 22px;
    margin-left: 9px;
    padding-left: 3px;
}

#custom-sr_end {
    border-radius: 0px;
    margin-right: 9px;
    padding-right: 3px;
}

#custom-sl_end {
    border-radius: 0px;
    margin-left: 9px;
    padding-left: 3px;
}

#custom-rr_end {
    border-radius: 0px 8px 8px 0px;
    margin-right: 9px;
    padding-right: 3px;
}

#custom-rl_end {
    border-radius: 8px 0px 0px 8px;
    margin-left: 9px;
    padding-left: 3px;
}
      '';
  };
}
