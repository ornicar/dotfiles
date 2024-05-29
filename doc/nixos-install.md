# Install minimal nixos

## Docs

https://nixos.org/manual/nixos/stable/
https://gist.github.com/Vincibean/baf1b76ca5147449a1a479b5fcc9a222

## First things first

sudo loadkeys colemak

## Network

https://nixos.org/manual/nixos/stable/#sec-installation-booting-networking

```sh
sudo systemctl start wpa_supplicant
wpa_cli

add_network
set_network 0 ssid "thib-wifi"
set_network 0 psk "mypassword"
set_network 0 key_mgmt WPA-PSK
enable_network 0
```

## Partitioning with UEFI (GTP)

```sh
sudo parted /dev/sda
mklabel gpt
mkpart root ext4 512MB -64GB
mkpart swap linux-swap -64GB 100%
mkpart ESP fat32 1MB 512MB
set 3 esp on
```

## Formatting

https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-formatting

```sh
sudo mkfs.ext4 -L nixos /dev/sda1
sudo mkswap -L swap /dev/sda2
sudo mkfs.fat -F 32 -n boot /dev/sda3
```

## Edit /etc/nixos/configuration.nix

```
console.keyMap = "colemak";
```

## Easy

It's all actually straightforward with `nixos-generate-config` and `nixos-install`.

## Setup

https://github.com/nix-community/awesome-nix
