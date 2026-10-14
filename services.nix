{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.mbsync = {
    enable = true;
    description = "Mailbox synchronization";
    serviceConfig = {
      type = "oneshot";
      ExecStart = "${pkgs.isync}/bin/mbsync";
    };
  };

  # obtained from: https://gitlab.com/shackra/goimapnotify/-/blob/master/goimapnotify%40.service?ref_type=heads
  systemd.user.services.imapnotify = {
    enable = true;
    description = "Execute scripts on IMAP mailbox changes (new/deleted/updated messages) using IDLE, golang version.";
    startLimitIntervalSec = 900;
    startLimitBurst = 5;
    wantedBy = ["default.target"];
    serviceConfig = {
      ImportCredential = "gmail-keys";
      Type = "simple";
      ExecStart = "${pkgs.goimapnotify}/bin/goimapnotify -conf %h/.config/imapnotify/gmail.json";
      Restart = "always";
      RestartSec = "30";
    };
  };

  systemd.user.timers.mbsync = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "2m";
      OnUnitActiveSec = "5m";
      Unit = "mbsync.service";
    };
  };
}
