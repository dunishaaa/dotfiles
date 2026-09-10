# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  # Configure keymap in X11
  services.xserver = {
	  xkb.layout = "us,es";
	  xkb.options = "grp:win_space_toggle";
  };
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  systemd.user.services.kanata = {
    enable = true;
    description = "Kanata keyboard remapper";
    documentation = [ "https://github.com/jtroo/kanata" ];
    serviceConfig = {
      Type="simple";
      ExecStart="${pkgs.kanata}/bin/kanata --cfg %h/.config/kanata/config.kbd";
      Restart="no";
    };
    wantedBy = [ "default.target" ];

  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.desktopManager.gnome.enable=true;
  services.displayManager.gdm.enable=true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."dunishaaa" = {
    isNormalUser = true;
    description = "dunishaaa";
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  programs.hyprland.enable = true;
  programs.niri.enable = true;

  programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  autosuggestions.enable = true;
	  syntaxHighlighting.enable = true;
	  shellAliases = {
	  	ll = "ls -la";
		update = "sudo nixos-rebuild switch";
	  };
	  histSize = 10000;
	  histFile = "$HOME/.zsh_history";
  };
  users.defaultUserShell = pkgs.zsh;



  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };
  services.open-webui = {
    enable = true;
  };
  services.kanata.enable = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    stow
    neovim
    swaybg
    starship
    wiremix
    kitty
    wget
    fastfetch
    btop
    hyprland
    hyprshutdown
    hyprpicker
    awww
    pass
    wallust
    quickshell
    gimp
    qbittorrent
    vlc
    thunar
    darktable
    thunderbird
    signal-desktop
    cava
    zsh
    fish
    pciutils
    kanata
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   services.pcscd.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     #pinentryFlavor = "gtk2";
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
