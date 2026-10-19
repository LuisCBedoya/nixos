{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./zsh.nix
    ./graphics.nix
    <home-manager/nixos>
  ];

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                        SISTEMA BASE                          ║
  # ╚══════════════════════════════════════════════════════════════╝

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                          RED                                 ║
  # ╚══════════════════════════════════════════════════════════════╝

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.networkmanager.settings.main.no-auto-default = "interface-name:enp3s0";

  networking.networkmanager.ensureProfiles.profiles = {
    "enp3s0-dhcp-mas-fija" = {
      connection = {
        id = "enp3s0-dhcp-mas-fija";
        type = "ethernet";
        interface-name = "enp3s0";
      };
      ipv4 = {
        method = "auto";
        address1 = "192.168.0.50/24";
      };
    };
  };

  # networking.firewall.allowedTCPPorts = [ 80 443 5173 8000 ];

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                     LOCALIZACIÓN                             ║
  # ╚══════════════════════════════════════════════════════════════╝

  time.timeZone = "America/Bogota";

  i18n.defaultLocale = "es_CO.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT    = "es_CO.UTF-8";
    LC_MONETARY       = "es_CO.UTF-8";
    LC_NAME           = "es_CO.UTF-8";
    LC_NUMERIC        = "es_CO.UTF-8";
    LC_PAPER          = "es_CO.UTF-8";
    LC_TELEPHONE      = "es_CO.UTF-8";
    LC_TIME           = "es_CO.UTF-8";
  };

  console.keyMap = "la-latin1";

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                       NIX / FLAKES                           ║
  # ╚══════════════════════════════════════════════════════════════╝

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "13:00:00";
    options = "--delete-older-than 2d";
  };

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                        USUARIOS                              ║
  # ╚══════════════════════════════════════════════════════════════╝

  users.users."luc" = {
    isNormalUser = true;
    description  = "luc";
    extraGroups  = [ "networkmanager" "wheel" "docker" ];
    shell        = pkgs.zsh;

    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAA... luc@windows"
    # ];
  };

  # Home Manager para el usuario luc
  home-manager.useGlobalPkgs = true;
  home-manager.users.luc = import ./home.nix;

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                     PAQUETES DEL SISTEMA                     ║
  # ╚══════════════════════════════════════════════════════════════╝

  environment.systemPackages = with pkgs; [
    # (Vacío: todas las herramientas ahora viven en home.nix)
  ];

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                        SERVICIOS                             ║
  # ╚══════════════════════════════════════════════════════════════╝

  # ── SSH ────────────────────────────────────────────────────────
  services.openssh = {
    enable       = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
  };

  # ── Base de datos: MariaDB ─────────────────────────────────────
  # services.mariadb = {
  #   enable = true;
  # };
}
