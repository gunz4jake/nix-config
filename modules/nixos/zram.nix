{ config, lib, pkgs, ... }:

{
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
  };
}
