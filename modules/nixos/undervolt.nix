{ config, lib, pkgs, ... }:

{
  # Intel undervolt for 8th gen (Coffee Lake) mobile CPU.
  # These are conservative starting offsets — adjust downward (more negative)
  # if temps/power are still high, or upward if you experience instability.
  #
  # NOTE: If the service fails to apply, your BIOS may have the undervolting
  # MSR locked (common after the Plundervolt / CVE-2019-11157 microcode patch).
  # Check BIOS for an "Overclocking Lock" or "Undervolt Protection" toggle.
  services.undervolt = {
    enable = true;

    # CPU core voltage offset (mV). Negative = lower voltage.
    coreOffset = -70;

    # CPU cache / ring bus offset. Usually safe to match coreOffset.
    uncoreOffset = -70;

    # Integrated GPU offset. Keep conservative to avoid display artifacts.
    gpuOffset = -40;

    # Reapply settings every 30 s (helps after suspend/resume resets).
    useTimer = true;
  };
}
