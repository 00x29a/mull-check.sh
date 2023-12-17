# Mullvad VPN/Tailscale Exit Node Status Checker

This script is designed to provide users with details about their Mullvad VPN or Tailscale Mullvad Exit Node connection status.

## Features

- Display the city of the VPN server you are connected to.
- Show the IP address assigned to you by the VPN.
- Indicate the country of the VPN server you are connected to.
- Check if your IP is blacklisted by any services.
- Reveal the type of the server you are connected to (e.g., OpenVPN, WireGuard).
- Display the hostname of the Mullvad VPN exit server.
- Verify if you are currently connected to Mullvad VPN.

## Usage

To use the script, simply run it from the command line with the desired options. If no options are provided, the script will display all available information.

```
./mull-check.sh [options]
```

### Options

- `-c`       Show the city of the VPN server you are connected to.
- `-i`       Show the IP address assigned to you by the VPN.
- `-C`       Show the country of the VPN server you are connected to.
- `-b`       Indicate whether your IP is blacklisted by any services.
- `-t`       Show the type of the server you are connected to (e.g., OpenVPN, WireGuard).
- `-H`       Show the hostname of the Mullvad VPN exit server.
- `-s`       Check if you are currently connected to Mullvad VPN.
- `--help`   Display help information and exit.

## Requirements

- `curl`
- `jq`

## License

This script is released under the MIT License. See the LICENSE file for more details.
