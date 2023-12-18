#!/bin/bash

# Define color constants
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display help
usage() {
    echo "Usage: $0 [options]"
    echo "This script provides details about your Mullvad VPN/Tailscale Exit Node connection status."
    echo "You can specify which detail to output using the options below."
    echo "If no options are provided, the default behavior is to display all available information."
    echo
    echo "Options:"
    echo " -c       Show the city of the VPN server you are connected to."
    echo " -i       Show the IP address assigned to you by the VPN."
    echo " -C       Show the country of the VPN server you are connected to."
    echo " -b       Indicate whether your IP is blacklisted by any services."
    echo " -t       Show the type of the server you are connected to (e.g., OpenVPN, WireGuard)."
    echo " -H       Show the hostname of the Mullvad VPN exit server."
    echo " -s       Check if you are currently connected to Mullvad VPN."  
    echo " --help   Display this help and exit."
}

# Get the current external IP address and Mullvad status
MULLVAD_STATUS=$(curl -s https://am.i.mullvad.net/json)

# Extracting the 'mullvad_exit_ip' status
MULLVAD_EXIT_IP=$(echo "$MULLVAD_STATUS" | jq -r '.mullvad_exit_ip')

# Check if Mullvad VPN is detected, if not print a message and exit
if [ "$MULLVAD_EXIT_IP" != true ]; then
    echo -e "${RED}Mullvad VPN is not being used.${NC}"
    exit 1
fi

# Check if we have any arguments, if not display general information
if [ $# -eq 0 ]; then
  IP=$(echo "$MULLVAD_STATUS" | jq -r '.ip')
  HOSTNAME=$(echo "$MULLVAD_STATUS" | jq -r '.mullvad_exit_ip_hostname')
  CITY=$(echo "$MULLVAD_STATUS" | jq -r '.city')
  COUNTRY=$(echo "$MULLVAD_STATUS" | jq -r '.country')
  BLACKLISTED=$(echo "$MULLVAD_STATUS" | jq -r '.blacklisted' | grep -q true && echo true || echo false)
  SERVERTYPE=$(echo "$MULLVAD_STATUS" | jq -r '.mullvad_server_type')

  # Output the extracted information
  echo -e "${GREEN}You are using Mullvad VPN.${NC}"
  echo -e "Mullvad Hostname: ${ORANGE}$HOSTNAME${NC}"
  echo -e "IP Address: ${ORANGE}$IP${NC}"
  echo -e "Location: ${ORANGE}$CITY, $COUNTRY${NC}"
  echo -e "Blacklisted: ${ORANGE}$BLACKLISTED${NC}"
else
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -c) CITY=$(echo "$MULLVAD_STATUS" | jq -r '.city')
          echo -e "City: ${ORANGE}$CITY${NC}";;
      -i) IP=$(echo "$MULLVAD_STATUS" | jq -r '.ip')
          echo -e "IP Address: ${ORANGE}$IP${NC}";;
      -C) COUNTRY=$(echo "$MULLVAD_STATUS" | jq -r '.country')
          echo -e "Country: ${ORANGE}$COUNTRY${NC}";;
      -b) BLACKLISTED=$(echo "$MULLVAD_STATUS" | jq -r '.blacklisted')
          echo -e "Blacklisted: ${ORANGE}$BLACKLISTED${NC}";;
      -t) SERVERTYPE=$(echo "$MULLVAD_STATUS" | jq -r '.mullvad_server_type')
          echo -e "Server Type: ${ORANGE}$SERVERTYPE${NC}";;
      -H) HOSTNAME=$(echo "$MULLVAD_STATUS" | jq -r '.mullvad_exit_ip_hostname')
          echo -e "Hostname: ${ORANGE}$HOSTNAME${NC}";;
      -s) echo -e "${GREEN}Connected to Mullvad VPN.${NC}";;
      --help) usage; exit 0;;
      *) echo "Unknown option: $1" >&2; usage; exit 1;;
    esac
    shift
  done
fi
