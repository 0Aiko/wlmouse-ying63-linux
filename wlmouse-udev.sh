#!/bin/bash

# Color definitions
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

echo -e "${BLUE}Searching for WLmouse keyboard via lsusb...${RESET}"

# Try to detect automatically
usb_line=$(lsusb | grep -i YING)

if [ -z "$usb_line" ]; then
    echo -e "${YELLOW}WLmouse not found automatically. Showing all USB devices:${RESET}"
    lsusb
    echo -e "${YELLOW}Please enter Vendor ID and Product ID manually. Example: 36a7 f888${RESET}"
    echo
    read -p "$(echo -e ${YELLOW}"Enter Vendor ID (4 hex digits): "${RESET})" VID
    read -p "$(echo -e ${YELLOW}"Enter Product ID (4 hex digits): "${RESET})" PID
else
    echo -e "${GREEN}Found:${RESET} $usb_line"
    VID=$(echo "$usb_line" | awk '{print $6}' | cut -d: -f1)
    PID=$(echo "$usb_line" | awk '{print $6}' | cut -d: -f2)
    echo -e "${YELLOW}Using Vendor ID:${RESET} $VID"
    echo -e "${YELLOW}Using Product ID:${RESET} $PID"
    read -p "$(echo -e ${BLUE}Press Enter to continue or Ctrl+C to cancel...${RESET})"
fi

# Validate
if [[ ! $VID =~ ^[0-9a-fA-F]{4}$ ]] || [[ ! $PID =~ ^[0-9a-fA-F]{4}$ ]]; then
    echo -e "${RED}Invalid VID or PID format. Must be 4 hexadecimal digits.${RESET}"
    exit 0
fi

# Create udev rule
RULE_FILE="/etc/udev/rules.d/99-wlmouse.rules"
echo -e "${BLUE}Creating udev rule at:${RESET} $RULE_FILE"

sudo bash -c "cat > $RULE_FILE" <<EOF
# Udev rules for WLmouse Ying63 keyboard
# USB device rule
SUBSYSTEM=="usb", ATTR{idVendor}=="36a7", ATTR{idProduct}=="f888", MODE="0666", TAG+="uaccess"
# HID raw device rule
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="f888", MODE="0666", TAG+="uaccess"
EOF

# Reload udev rules
echo -e "${BLUE}Reloading udev rules...${RESET}"
sudo udevadm control --reload-rules
sudo udevadm trigger

echo -e "${GREEN}Done!${RESET}"
echo -e "${BLUE}Now open your browser and go to the WLmouse configuration site. (or click to link with pressed ctrl)${RESET}"
echo -e "https://chn.wlmouse.com/kb/connect"

read -p "$(echo -e ${BLUE}Press Enter to exit...${RESET})"

