#!/bin/bash

# Define the device names
HEADPHONES_ID=alsa_output.usb-0c76_Fosi_Audio_K5_Pro-00.iec958-stereo
SPEAKERS_ID=alsa_output.pci-0000_13_00.1.hdmi-stereo-extra3

# Check the current default device
CURRENT_DEFAULT=$(wpctl list audio sinks | grep '*' | awk '{print $2}')

if [ "$CURRENT_DEFAULT" == "$HEADPHONES_ID" ]; then
    pactl set-default-sink $SPEAKERS_ID
else
    pactl set-default-sink $HEADPHONES_ID
fi

