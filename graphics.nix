{ config, pkgs, ... }:

{
  # ╔══════════════════════════════════════════════════════════════╗
  # ║                    GRÁFICOS (NVIDIA + INTEL)                 ║
  # ╚══════════════════════════════════════════════════════════════╝

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver      
      vpl-gpu-rt             
      intel-vaapi-driver    
      libva-vdpau-driver   
      libvdpau-va-gl
    ];
  };

  
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                        DOCKER + GPU                          ║
  # ╚══════════════════════════════════════════════════════════════╝

  virtualisation.docker.enable = true;

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker.daemon.settings.features.cdi = true;

  # ╔══════════════════════════════════════════════════════════════╗
  # ║                          CUDA                                ║
  # ╚══════════════════════════════════════════════════════════════╝

  nixpkgs.config.cudaSupport = true;

  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
}
