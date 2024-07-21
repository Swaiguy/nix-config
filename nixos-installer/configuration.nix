{pkgs, ...}: {
  # ssh-agent is used to pull my private secrets repo from github when deploying my nixos config.
  programs.ssh.startAgent = true;

  ##FOR /mnt/etc/nixos/configuration.nix
    ##imports =
    ##[ # Include the results of the hardware scan.
      ##./hardware-configuration.nix
    ##];

  users.users."kry" = {
    # generated by `mkpasswd -m scrypt`
    # we have to use initialHashedPassword here when using tmpfs for /
    password = "123";
    home = "/home/kry";
    isNormalUser = true;
    extraGroups = [
      "kry"
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "wireshark"
      "adbusers"
      "libvirtd"
    ];
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kry";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    gnumake
    wget
    just # a command runner(replacement of gnumake in some cases)
    curl
    nix-output-monitor
    kdePackages.kate
  ];
  networking = {
    # configures the network interface(include wireless) via `nmcli` & `nmtui`
    networkmanager.enable = true;
    defaultGateway = "192.168.18.1";
  };
  system.stateVersion = "24.05";
}
