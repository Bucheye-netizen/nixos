{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./common.nix
        ./configuration.nix
      ];
    };
  };
}
