{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.activation.linkNvim = config.lib.dag.entryAfter ["writeBoundary"] ''
    rm -rf $HOME/.config/nvim
    ln -sfn /home/luc/dotfiles/nvim $HOME/.config/nvim
  '';

  home.activation.linkLsd = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.config
    rm -rf $HOME/.config/lsd
    ln -sfn /home/luc/dotfiles/lsd $HOME/.config/lsd
  '';

  programs.git = {
    enable = true;
    userName = "user";     
    userEmail = "user@email.com"; 
  };

  home.packages = with pkgs; [
    # Herramientas base
    git
    wget
    curl
    tree

    # Editor
    neovim
    ripgrep

    # Utilidades de shell
    lsd

    # Monitoreo
    fastfetch
    nvitop
    nvtopPackages.nvidia

    # Utilidades NVIDIA
    vulkan-tools
    clinfo

    # Utilidades Intel
    libva-utils
    intel-gpu-tools

    # Node & Treesitter
    nodejs_24
    tree-sitter
    gcc
    gnumake

    # ── LSP Servers 
    lua-language-server
    typescript-language-server
    emmet-language-server
    vscode-langservers-extracted
    yaml-language-server
    bash-language-server
    marksman

    # ── Formatters 
    stylua
    prettierd
    taplo
    shfmt

    # ── Linters 
    shellcheck
    markdownlint-cli2
    eslint
    stylelint
    htmlhint
  ];
}
