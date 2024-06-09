# Linux start up
### Pacman Configuration
sudo nano /etc/pacman.conf
Color [uncommennt]
ParallelDownloads = 10
### Remove not usable soft
sudo pacman -Rsn gnome-software epiphany gnome-calendar gnome-contacts gnome-maps gnome-music gnome-weather gnome-user-docs totem yelp gnome-user-share gnome-characters simple-scan gnome-font-viewer gnome-remote-desktop orca malcontent gnome-text-editor loupe gnome-connections gnome-tour

### Install usable/needing soft
sudo pacman -S git zsh npm yarn nvidia nvidia-settings bluez nvim mpv flatpak

### Programs
#### Browser
sudo pacman -S chromium
#### Telegram 
sudo pacman -S telegram-desktop
#### Discord
flatpak --install discord
#### Steam
sudo pacman -S steam
#### Obsidian
sudo pacman -S obsidian
#### Office
sudo pacman -S libreoffice-still
#### Bledner
sudo pacman -S blender
#### Krita
sudo pacman -S krita


### Unity developing on NVIM

1.1 - https://aur.archlinux.org/unityhub.github
1.2 - sudo pacman -S dotnet-sdk mono mono-tools mono-msbuild mono-msbuild-sdkresolver mono-addins
2.1 - https://github.com/OmniSharp/omnisharp-roslyn/releases
2.2 - unzip omnisharp-linux-x86.zip -d ~/.omnisharp
2.3 - chmod +x /home/delboni/.omnisharp/run
2.4 - sudo ln -sf /home/delboni/.omnisharp/ /usr/local/lib/omnisharp
3 - https://github.com/Domeee/com.cloudedmountain.ide.neovim?tab=readme-ov-file
