{ config, pkgs, nodes, ... }: {

  imports = [
    ../defaults.nix
    ../test.nix
    ../../modules/audio.nix
    ../../modules/x.nix
    ../../modules/console.nix
    ../../modules/ipfs.nix
    ../../modules/localserver.nix
    ../../modules/keylayout.nix
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    config.sshkeys.mac.nixos.root
  ];

  virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    nixops
    neofetch
    youtube-dl
    ffmpeg-full
  ];

  environment.variables.PATH = "/cfg/bin";

  networking = {
    nameservers = [
      nodes.server.config.deployment.targetHost
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    nixPath = [
      "cfg=/cfg"
      "nixpkgs=/cfg/nixpkgs"
      "nixos-config=/cfg/hosts/mac"
    ];
  };

  services.dbus.socketActivated = true;

  services.usbmuxd.enable = true;

  boot.supportedFilesystems = [ "exfat" "ntfs" ];
}
