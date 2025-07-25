# My NixOS Configuration

Welcome to my NixOS configuration repository! This setup defines a secure, modern, and user-friendly NixOS system with an encrypted disk, BTRFS subvolumes, and a GNOME desktop environment.

## Overview

- **Hostname**: NixOS
- **Desktop Environment**: GNOME with GDM
- **Disk Encryption**: LUKS with *TPM2 auto-unlocking (WIP: TPM not unlocking automatically on my Asus Zenbook, still works with passphrase)
- **File System**: BTRFS with subvolumes
- **Bootloader**: systemd-boot (EFI)
- **Networking**: NetworkManager
- **Time Zone**: America/Los_Angeles
- **Locale**: en_US.UTF-8

## Key Features

- **Encrypted Root**: Uses LUKS with TPM2 for secure boot-time unlocking. (WIP: TPM not unlocking automatically on my Asus Zenbook, still works with passphrase)
- **BTRFS Subvolumes**: Organized as `/`, `/home`, `/nix`, `/persist`, `/var/log`, and `/swap` (32 GB), with `zstd` compression and `noatime` for performance.
- **Hibernation**: Configured with a `resume_offset=533760` and a swap subvolume.
- **GNOME Desktop**: Includes GDM and a custom keyboard mapping (Caps Lock as Hyper).
- **Services**:
  - Printing via CUPS.
  - Audio with PipeWire (PulseAudio compatible).
  - Input handling with libinput.
- **User Account**: `hakkero` with sudo privileges and the `tree` package.

## Configuration Files

- **`configuration.nix`**:
  - Main system configuration, including boot, networking, desktop, and services.
- **`disk-config.nix`**:
  - Declarative disk setup using `disko`, defining partitions and BTRFS subvolumes.

## Prerequisites

- Generated `hardware-configuration.nix` (run `nixos-generate-config --no-filesystems --root /mnt` if needed).
