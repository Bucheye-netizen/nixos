{
  config,
  pkgs,
  ...
}: {
  users.users.${config.username}.packages = with pkgs; [
    foot
    kitty
    nixd
    perlcritic
    brightnessctl
    rustup
    php
    laravel
    alejandra
    typst
    tinymist
    dig
    ruff
    tombi
    perlnavigator
    (texliveMedium.withPackages (
      ps:
        with ps; [
          enumitem
        ]
    ))
    gdb
    google-cloud-sdk
    clang
    clang-manpages
    lldb
    valgrind
    tcl
  ];

  programs.java.enable = true;
}
