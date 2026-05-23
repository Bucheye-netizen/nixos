# Various cli utilities that I frequently
{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.aerc = {
    enable = true;
    after = ["network.target"];
    description = "Aerc email daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.aerc}/bin/aerc";
    };
  };
}
