#!/bin/sh

echo "Sync configuration with hyprland"

ARRAY=(/etc/sysctl.d/40-disable-ipv6.conf /etc/default/grub /etc/v2raya ~/.config/nvim ~/.config/hypr /usr/lib/systemd/system/v2raya.service /etc/locale.gen ~/.config/wal /etc/libvirt/qemu.conf ~/.config/ghostty ~/.zshrc /etc/sddm.conf /usr/share/sddm/themes/silent ~/.config/wal-vide-sync.sh)

# mv /etc/sysctl.d/40-disable-ipv6.conf ./
# mv /etc/default/grub ./

copy() {
	sudo cp -r $1 ./ 
}

for i in ${ARRAY[@]} 
do
	copy $i
done
