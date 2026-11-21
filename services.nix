{
  pkgs,
  config,
  ...
}: {
  # Claudius recommended:
  systemd.user.services.imapnotify = {
    description = "goimapnotify";
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    path = with pkgs; [libsecret dunst isync coreutils];
    serviceConfig = {
      ExecStart = "${pkgs.goimapnotify}/bin/goimapnotify -conf %h/.config/imapnotify/gmail.json";
      Restart = "always";
      RestartSec = 30;
    };
  };

  systemd.user.services.mbsync = {
    path = with pkgs; [isync notmuch libsecret];
    serviceConfig.Type = "oneshot";
    script = "mbsync -a && notmuch new";
  };

  systemd.user.timers.mbsync = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "2m";
      OnUnitActiveSec = "15m";
    };
  };
}
