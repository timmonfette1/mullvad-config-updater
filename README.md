# mullvad-config-updater
This repository holds a simple shell script I use to modify the WireGuard config files for Mullvad to use additional security.

## Prerequisties
This assumes that you have a Mullvad account, have installed WireGuard for your system and that you have downloaded at least one WireGuard configuration file for Mullvad (either manually or using their provided script to bulk download all of them at `https://mullvad.net/media/files/mullvad-wg.sh`).

## Execute
The script is simple and adds the following support to all of the config files found in `/etc/wireguard/`:
- Enables a kill switch.
- Modifies the DNS line in the config to guard against DNS leaking (additional settings may need to be tweaked on your specific browser).

The script can simply be run by an account with `sudo` access to update every config file for: `./mullvad-config-updater.sh`.
