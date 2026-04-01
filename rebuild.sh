if ! [ "$1" ]; then
  printf "specify computer: dell or lenovo\n"
  exit 1
fi

sudo nixos-rebuild switch --flake ~/nixos#"$1"
