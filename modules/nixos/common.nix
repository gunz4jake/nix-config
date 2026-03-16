{ ... }:

{
  # Systemd-boot EFI bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Quiet boot with Plymouth splash
  boot.kernelParams = [ "quiet" ];

  # Use systemd in initrd for FIDO2 LUKS unlock support
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."root".crypttabExtraOpts = [ "fido2-device=auto" ];

  time.timeZone = "America/Detroit";

  programs._1password-gui.polkitPolicyOwners = [ "jacob" ];

  custom.desktop.environment = "gnome";
  custom.plymouth.enable = true;

  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
