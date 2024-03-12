{ lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings.main = {
      layer = "top";

      spacing = 4;

      modules-left = [
        "sway/workspaces"
        "sway/mode"
      ];

      modules-center = [ 
        "clock"
      ];

      modules-right = [
        "idle_inhibitor"
        "network"
        "temperature"
        "pulseaudio"
        "backlight"
        "battery"
        "tray"
        "custom/space"
      ];

      "sway/workspaces" = {
        all-outputs = true;
        format = "{name}";
      };

      "sway/mode" = { format = ''<span style="italic">{}</span>''; };

      pulseaudio = {
        format = "{icon} {volume}%  {format_source}";
        format-bluetooth = " {volume}%  {format_source}";
        format-bluetooth-muted = "   {format_source}";
        format-muted = "   {format_source}";
        format-source = " {volume}%";
        format-source-muted = " ";
        format-icons = {
          headphones = " ";
          handsfree = "󰋎 ";
          headset = "󰋎 ";
          phone = " ";
          portable = " ";
          car = " ";
          default = [ " " " " " " ];
        };
        on-click = "${pkgs.ponymix}/bin/ponymix -t sink toggle";
        on-scroll-up = "${pkgs.ponymix}/bin/ponymix increase 1";
        on-scroll-down = "${pkgs.ponymix}/bin/ponymix decrease 1";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = " ";
          deactivated = " ";
        };
      };

      network = {
        format-wifi = "   {essid}";
        format-ethernet = "󰈀  {ifname}: {ipaddr}/{cidr}";
        format-linked = "󰌘  {ifname} (No IP)";
        format-disconnected = "⚠  Disconnected";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };

      temperature = {
        critical-threshold = lib.mkDefault 90;
        format = "{icon} {temperatureC}°C";
        format-icons = [ "" "" "" ];
      };

      backlight = {
        device = "intel_backlight";
        format = "{icon}  {percent}%";
        format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
        on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set +1%";
        on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
      };

      battery = {
        bat = "BAT0";
        states = {
          good = 90;
          warning = 30;
          critical = 15;
        };
        format = "{icon}  {capacity}%";
        format-charging = "󰂄  {capacity}%";
        format-plugged = "   {capacity}%";
        format-alt = "{icon}  {time}";
        format-icons = [ " " " " " " " " " " ];
      };

      clock = {
        interval = 60;
        tooltip-format = "<tt>{calendar}</tt>";
        format = "󰥔  {:%H:%M}";
      };

      tray = {
        icon-size = lib.mkDefault 16;
        spacing = lib.mkDefault 4;
      };

      "custom/space" = {
        format = " ";
      };
    };

    systemd = {
      enable = true;
      target = "sway-session.target";
    };
  };

  systemd.user.services.waybar.Service.Restart = lib.mkForce "always";
}
