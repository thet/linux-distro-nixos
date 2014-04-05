{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Use the gummiboot efi boot loader.
  boot.loader.grub.enable = false;
  boot.loader.gummiboot.enable = true;
  boot.loader.gummiboot.timeout = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "luft"; # Define your hostname.
  networking.connman.enable = true;  # Enables wireless.

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      #layout = 'us';
      synaptics.enable = true;
      windowManager.awesome.enable = true;
      displayManager.slim.enable = true;		
      desktopManager.xfce.enable = true;
    };
  };
  hardware.opengl.videoDrivers = [ "intel" ];

  fileSystems = [
    { mountPoint = "/home";
      device = "/dev/sda9";
      options = "defaults,discard,noatime";
    }
    { mountPoint = "/tmp";
      device = "tmpfs";
      fsType = "tmpfs";
      options = "nosuid,nodev,relatime";
    }
  ];
  swapDevices = [
    { device = "/dev/sda11"; }
  ];

  environment = {
    interactiveShellInit = ''
        export EDITOR="vim"
        export EMAIL=johannes@raggam.co.at
        export FULLNAME="Johannes Raggam"
    '';
    systemPackages = with pkgs; [

      chromiumWrapper
      firefoxWrapper
      vimHugeX
      xlibs.xmodmap
      # ...

    ];
  };

}
