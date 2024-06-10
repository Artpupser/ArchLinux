# Linux start up

### Pacman Configuration

sudo nano /etc/pacman.conf
Color
ParallelDownloads = 10

### Remove not usable soft

sudo pacman -Rsn gnome-software epiphany gnome-calendar gnome-contacts gnome-maps gnome-music gnome-weather gnome-user-docs totem yelp gnome-user-share gnome-characters simple-scan gnome-font-viewer gnome-remote-desktop orca malcontent gnome-text-editor loupe gnome-connections gnome-tour

### Install usable/needing soft

sudo pacman -S git zsh npm yarn nvidia nvidia-settings bluez code mpv flatpak

### Clipboard API

sudo pacman -S xclip

### AUR Installer

#### yay

### Programs

#### Browser

sudo pacman -S chromium

#### Telegram

sudo pacman -S telegram-desktop

#### Discord

flatpak --install discord

#### Steam

yay -S steam

#### Obsidian

sudo pacman -S obsidian

#### Office

sudo pacman -S libreoffice-still

#### Bledner

sudo pacman -S blender

#### Krita

sudo pacman -S krita

### Gaming

yay -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
yay -S proton wine lutris steam gamemode lib32-gamemode electron

### Unity

1.1 - https://aur.archlinux.org/unityhub.github
1.2 - sudo pacman -S dotnet-sdk mono mono-tools mono-msbuild mono-msbuild-sdkresolver mono-addins

### Unity + NVIM

1.1 - https://github.com/OmniSharp/omnisharp-roslyn/releases
1.2 - unzip omnisharp-linux-x86.zip -d ~/.omnisharp
1.3 - chmod +x /home/delboni/.omnisharp/run
1.4 - sudo ln -sf /home/delboni/.omnisharp/ /usr/local/lib/omnisharp
2 - https://github.com/Domeee/com.cloudedmountain.ide.neovim?tab=readme-ov-file
