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
      tree-sitter
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
      rclone
      nh
      rbw

      # attempting to get terminal based email working
      aerc
      w3m
      libsecret
      oama
      neovim
      page
      luajitPackages.tree-sitter-cli
      bc
      chawan
      spicetify-cli

      khal
      khard
      vdirsyncer
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
    MANPAGER = "nvim +Man!";
  };
}
