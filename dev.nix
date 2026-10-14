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
    markdown-oxide
    ghidra
    kakoune
    zig
    zls
    meson
    doxygen
    python314Packages.breathe
    pkg-config
    gettext
    cmake
    girara
    rstudioWrapper
    (rWrapper.override
      {
        packages = with rPackages; [
          tidyverse
          ggplot2
          lobstr
          rvest
        ];
      })
  ];

  programs.java.enable = true;
}
