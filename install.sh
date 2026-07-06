#!/bin/sh
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'

NEED="--needed"
NOCONFIRM="--noconfirm"

LOGICAL_TAGS=(
  "" # 0
  "$NEED" # 1
  "$NOCONFIRM" # 2
  "$NEED $NOCONFIRM" # 3
)

NAMES=(
  "Base packages" 
  "Dkms nvidia driver" 
  "Basic utilities for correct work many programs"
  "HYPRLAND packages"
  "Network packages"
  "Aplications for work packages"
  "Aesthetics packages"
  "Qemu + KVM"
  "Ruby packages"
  "Nvidia supported packages + lib32"
)
PACKAGES=(
  "git base-devel"
  "nvim npm pnpm nodejs dotnet-runtime dotnet-sdk mono python lrzip unrar unzip unace p7zip squashfs-tools rbenv lua perl vlc vlc-plugins-all ttf-jetbrains-mono-nerd ttf-firacode-nerd waybar wlogout clang"
  "nvidia"
  "hyprland rofi ghostty nemo flameshot sddm xdg-desktop-portal-hyprland waybar hyprpolkitagent hyprpaper"
  "pavucontrol firefox obsidian blender krita zsh qbittorrent unityhub" # [APPLICATIONS]
  "networkmanager network-manager-applet xray v2raya"
  "socat netcat python-pywal imagemagick mpvpaper"	
  "mesa mesa-utils xf86-video-qxl spice-vdagent spice-protocol edk2-ovmf qemu-full libvirt virt-manager virt-viewer dnsmasq bridge-utils edk2-ovmf polkit lxqt-policykit dmidecode virglrenderer spice spice-gtk virt-viewer"
  "ruby-build rbenv"
  "nvidia-settings opencl-nvidia nvidia-settings mesa mesa-utils vulkan-icd-loader vulkan-tools lib32-nvidia-utils lib32-mesa"
  "gtkmm3 jsoncpp libsigc++ fmt wayland chrono-date spdlog gtk3 gobject-introspection libgirepository libpulse libnl libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient sndio libevdev libxkbcommon upower meson cmake scdoc wayland-protocols glib2-devel"
)

function get_package_manager() {
  if command -v yay &> /dev/null; then
    echo 'sudo yay'
  else
    echo 'sudo pacman'
  fi
}

function echo_color() {
  echo -e "$2 $1 $NC"
}

function install_package() {
  MANAGER=$(get_package_manager)
  if pacman -Qi "$1" &> /dev/null; then
    echo_color "Package $1 already installed" "$BLUE"
  else
    echo_color "Installation package: $1" $YELLOW
    $MANAGER -S ${LOGICAL_TAGS[$2]} $1
  fi
}

function install_packages() {
  NAME=${NAMES[$1]}
  POINTER=${PACKAGES[$1]}
  echo_color "Packages category: [$NAME]" $GREEN
  for i in ${POINTER[@]};
  do
    install_package $i $2
  done
}

function install_yay() {
  if ! command -v yay &> /dev/null; then
    echo_color "Installation nvidia drivers (if you have rtx 4060 -> 7 -> beta dkms)" $YELLOW
    git clone https://aur.archlinux.org/yay/git && cd yay && makepkg -si && sleep 1 && cd .. && rm -rf yay
  fi
}

function copy_configurations() {
  echo_color "Copy configuration to computer" $RED
  mkdir -p ~/.config/v2raya/
  sudo cp ./v2raya /etc/v2raya/
  sudo cp ./v2raya.service /usr/lib/systemd/system/v2raya.service
  sudo cp ./40-disable-ipv6.conf /etc/sysctl.d/
  sudo cp ./grub /etc/default/grub
  sudo cp ./pywall_to_starhip.sh ~/.config/
  sudo cp ./wal-vide-sync.sh ~/.config/
  sudo cp ./mpvpaper_auto_pause.sh ~/.config/
  sudo cp ./mpvpaper_start.sh ~/.config/
  sudo cp ./sddm.conf /etc/sddm.conf
  sudo cp -r ./silent /usr/share/sddm/themes/silent
  echo_color "Apply configurations" $GREEN	
  systemctl restart systemd-sysctl.service
  grub-mkconfig -o /boot/grub/grub.cfg
}

function install_lazy() {
  if [ ! -e "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    echo_color "Lazy plugin installing" $YELLOW
    git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
  else
    echo_color "Lazy plugin already installed" $GREEN
  fi
}

function install_ruby {
  if ! rbenv versions --bare | grep -q "^3.3.8$"; then
    echo_color "Ruby 3.3.8 installation use 'rbenv'" $YELLOW
    install_packages 8 3
    rbenv install 3.3.8 && rbenv global 3.3.8 && rbenv local 3.3.8 && rbenv shell 3.3.8 && rbenv rehash && rbenv init
    export PATH="$HOME/.rbenv/bin:$PATH"
    source ~/.bashrc
    sleep 1
    gem install rubocop ruby-lsp solargraph erb
  else
    echo_color "Ruby 3.3.8 allready installed" $GREEN 
  fi
}

function setup_qemu {
  echo "Setup/Configuration qemu  + KVM + GPU"
  if ! systemctl is-enabled libvirtd &>/dev/null; then
    sudo systemctl enable --now libvirtd
  else
    echo "libvirtd already enabled"
  fi

  USERNAME="$USER"

  for group in libvirt video render kvm; do
    if id -nG "$USERNAME" | grep -qw "$group"; then
      echo "User already in $group"
    else
      sudo usermod -aG "$group" "$USERNAME"
      echo "Added user to $group"
    fi
  done

  sudo cp ./qemu.conf /etc/libvirt/qemu.conf
}

function setup_v2raya() {
  if ! systemctl is-enabled --quiet NetworkManager-wait-online.service; then
    echo_color "NetworkManager-wait-online.service enable" $YELLOW 
    sudo systemctl enable NetworkManager-wait-online.service
  else
    echo_color "NetowrkManager-wait-online.service already enabled" $GREEN
  fi
  if ! systemctl is-enabled --quiet v2raya; then
    echo_color "v2raya.service enable" $YELLOW 
    sudo systemctl enable v2raya
  else
    echo_color "v2raya.service already enabled" $GREEN
  fi
}

function install_omz() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo_color "Oh my zsh, installing" $YELLOW
    RUNZSH=no CHSH=no zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo_color "Oh my zsh, already installed" $GREEN
  fi

  if ! command -v starship >/dev/null 2>&1; then
    echo_color "Starship, installing" $YELLOW
    curl -sS https://starship.rs/install.sh | sh
    echo_color "Starship init to .zshrc" $YELLOW
    eval "$(starship init zsh)"
  else
    echo_color "Starship, already installed" $GREEN
  fi

  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo_color "Installing zsh-syntax-highlighting" $YELLOW
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  else
    echo_color "zsh-syntax-highlighting already installed" $GREEN
  fi

  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo_color "Installing zsh-autosuggestions" $YELLOW
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  else
    echo_color "zsh-autosuggestions already installed" $GREEN
  fi
}

function setup_ssh() {
  local key="$HOME/.ssh/id_ed25519"

  mkdir -p "$HOME/.ssh"

  if ! [[ -f "$key" ]]; then
    echo_color "SSH key generation" $YELLOW
    ssh-keygen -t ed25519 -f "$key" -N "" -q
    return 0
  else
    echo_color "SSH key already exists: $key" $GREEN
  fi

}

install_packages 0 1
install_yay
install_packages 1 0
install_packages 2 3
install_packages 3 1
# # DANGER ENABLE
# # copy_configurations
install_packages 4 3
install_packages 5 3
setup_v2raya
install_packages 6 2
install_packages 7 3
install_lazy
install_ruby # 8
install_packages 9 3
setup_qemu
install_packages 9 3
install_omz 
setup_ssh
exit

