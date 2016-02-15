# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.cleanTmpDir = true;
  boot.enableContainers = true;
  boot.hardwareScan = true;
  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;
  boot.loader.grub.gfxmodeBios = "1024x768";
  boot.loader.grub.version = 2;
  boot.supportedFilesystems = [ "btrfs" ];
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda";

  networking.hostName = "master.bigmed.ro"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.opengl.driSupport = true;
  hardware.pulseaudio.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "ro";
    defaultLocale = "ro_RO.UTF-8";
  };

  networking.firewall.allowPing = true;
  networking.firewall.autoLoadConntrackHelpers = true;
  networking.firewall.checkReversePath = true;
  networking.firewall.connectionTrackingModules = [ "ftp" "irc" "sane" "sip" "tftp" "amanda" "h323" "netbios_sn" "pptp" "snmp" ];
  networking.firewall.enable = true;
  networking.nat.enable = true;
  networking.networkmanager.enable = true;
  networking.useNetworkd = true;

  nix.gc.dates = "13:13";
  nix.useChroot = true;

  powerManagement.cpuFreqGovernor = "ondemand";
  powerManagement.enable = true;

  programs.bash.enableCompletion = true;
  programs.man.enable = true;

  security.rngd.enable = true;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    firefox
    gitAndTools.gitFull
    kde4.krusader
    wget
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "ro";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.bigmed = {
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/bigmed";
    isNormalUser = true;
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
