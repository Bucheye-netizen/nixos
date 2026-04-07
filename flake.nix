{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
      modules = [
        ./dell.nix
      ];
    };

    nixosConfigurations.legion = nixpkgs.lib.nixosSystem {
      modules = [
        ./lenovo.nix
      ];
    };
  };
}
