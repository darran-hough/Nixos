# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
 # boot.loader.systemd-boot.enable = true;
 # boot.loader.efi.canTouchEfiVariables = true;
boot = {
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  kernelParams = [ "quiet" "splash" "vga=current" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];
  consoleLogLevel = 0;
  initrd.verbose = false;
};





fileSystems = {

  "/mnt/M2Games" = {
    device = "/dev/disk/by-uuid/009a3b2b-2355-4825-a8ba-bfbfe2548a46"; # replace with the actual UUID of your first drive
    fsType = "ext4"; # replace with the actual filesystem type of your first drive
  };

  "/mnt/HDDGames" = {
    device = "/dev/disk/by-uuid/940b261b-7ae0-4c46-a91f-e62720a55d42"; # replace with the actual UUID of your second drive
    fsType = "ext4"; # replace with the actual filesystem type of your second drive
  };

  "/mnt/SSDGames" = {
    device = "/dev/disk/by-uuid/5c21a66d-41e7-4b4e-bbb5-27c57b101b02"; # replace with the actual UUID of your second drive
    fsType = "ext4"; # replace with the actual filesystem type of your second drive
  };


  # Add more drives as needed
};







  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  


fonts.fontDir.enable = true;
fonts.packages = with pkgs; [
	nerdfonts
	font-awesome
	google-fonts
];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
 

  # enable flatpak
	services.flatpak.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
	
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dhsplice = {
    isNormalUser = true;
    description = "dhsplice";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	chromium
	git
	wget
	steam
	bitwig-studio
	gimp-with-plugins
	vlc
	deja-dup
	piper
	lxappearance
	gtk4
	packagekit
	discord	
	
    ];

  };
  




  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget	
	alsa-scarlett-gui
	libuuid
	# wineWowPackages.staging
	wineWowPackages.full
	winetricks 
	yabridge
  	yabridgectl
	pkgs.gnome3.gnome-tweaks
	
	   
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?;





}
