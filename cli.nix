# Various cli utilities that I frequently
{
  pkgs,
  config,
  ...
}: {
  programs.fish.enable = true;

  users.users.${config.username} = {
    shell = pkgs.fish;
    packages = with pkgs; [
      helix
      starship
      tmux
      gh
      acpi
      clang-tools
      clang-analyzer
      coreutils-full
      gcc
      gnumake
      stow
      eza
      parted
      usbutils
      xxd
      nitch
      fd
      ripgrep
      fzf
      btop
      rustup
      bash-language-server
      lazygit
      tokei
      zip
      unzip
      dig
      shellcheck
      cpufetch
      nix-tree
      trashy
      pandoc
      unixtools.netstat
      netcat
      sshfs
      fuse
      gdb
      ffmpeg
      jq
      exiftool
      fish-lsp
      fastfetch
      valgrind
      # attempting to get terminal based email working
      aerc
      w3m
      nh
      rclone
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    man-pages
    man-pages-posix
  ];

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "kitty";
    GDK_BACKEND = "wayland";
  };
}
