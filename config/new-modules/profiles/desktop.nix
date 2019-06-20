{ pkgs, nodes, config, lib, ... }:

with lib;

{

  imports = [ "${(import ../../sources).futureInternetProjects}/module.nix" ];

  options.mine.profiles.desktop = {
    enable = mkEnableOption "desktop config";
  };

  config = mkIf config.mine.profiles.desktop.enable {

    mine.hueadm.enable = true;

    eth.futureInternet.enable = true;

    mine.emacs.enable = true;

    mine.newsboat.enable = true;

    mine.userConfig = {
      services.flameshot.enable = true;
      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
      };
    };

    mine.taskclient.enable = true;

    mine.x.enable = true;
    mine.wm.enable = true;
    mine.dev.idris.enable = true;
    mine.dev.haskell.enable = true;

    mine.music.client = {
      enable = true;
      server = nodes.protos;
    };

    nix.extraOptions = ''
      keep-derivations = true
      keep-outputs = true
    '';

    environment.systemPackages = with pkgs; [
      neofetch
      youtube-dl
      ffmpeg-full
      stack
      imagemagick7Big
      deluge
      nix-prefetch-git
      sshfs
      nix-index
      mine.soph
      mine.imgurdl
      mine.Dark
      unrar
      (
        let src = (import ../../sources).lorri;
        in import src { inherit src; }
      )
      cachix
    ];

    services.usbmuxd.enable = true;

    services.dbus.socketActivated = true;

    boot.supportedFilesystems = [ "exfat" "ntfs" ];

    boot.loader.grub.splashImage = config.mine.assets.grub;

  };

}
