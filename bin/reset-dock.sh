#!/bin/bash
echo "Resetting USB-C subsystem..."
sudo modprobe -r typec_displayport typec_ucsi 
sleep 2
sudo modprobe typec_ucsi typec_displayport
echo "Reset complete. Try reconnecting dock."
