#/bin/sh
clear
echo "---------------------------------------------"
echo "Only run this script once you've switched the graphics to NVIDIA driver 460 or NVIDIA driver 470 using Driver Manager"
echo "---------------------------------------------"
echo "Tested on Linux Mint 20.2 UMA"
echo "---------------------------------------------"
echo "Have you switched your graphics to NVIDIA? (y/n)? "
echo "---------------------------------------------"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
    # adding options nvidia-drm modeset=1 to /lib/modprobe.d/nvidia-graphics-drivers.conf 
    sudo cp -a nvidia-graphics-drivers.conf /lib/modprobe.d/
    sudo update-initramfs -u
    # remove the drivers not useful after reboot
    sudo apt remove xserver-xorg-video-fbdev
    echo "---------------------------------------------"
    echo "Done! Reboot and enjoy complete hardware acceleration."
else
    echo "Okay, run this when you've switched your graphics."
fi
