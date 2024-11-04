let buildingInterface = [{
   title: "Start",
   list: [
      "pacman -S git",
      "cd ~/",
      "git clone https://github.com/Jguer/yay.git",
      "cd ~/yay",
      "makepkg -sric",
      "cd ..",
      "yay",
      "pacman -Suy ",
   ]
},
{
   title: "Zsh",
   list: [
      "yay -S zsh",
      "sh -c \"$(curl -fsSL https://install.ohmyz.sh/)\"",
      "nano ~/.zshrc",
      "find parameter > ZSH_THEME > put this > \"powerlevel10k/powerlevel10k\"",
      "reboot terminal",
   ]
},
{
   title: "Optimization",
   list: [
      "sudo pacman -Rns $(pacman -Qeq gnome-software gnome-calendar gnome-calls gnome-characters gnome-chess gnome-clocks gnome-contacts gnome-maps gnome-music gnome-notes gnome-photos gnome-remote-desktop gnome-text-editor gnome-tour gnome-user-docs gnome-font-viewer gnome-weather totem sushi epiphany) ",
   ]
},
{
   title: "Drivers",
   list: [
      "yay -S nvidia nvidia-utils nvidia-settings opencl-nvidia mesa mesa-utils"
   ]
},
{
   title: "Programs",
   list: [
      "yay -S libreoffice qbittorrent obsidian firefox vlc telegram-desktop visual-studio-code-bin blender krita"
   ]
},
{
   title:"Core",
   list: [
      "yay -S dotnet-sdk dotnet-runtime python lrzip unrar unzip unace p7zip squashfs-tools",
   ]
},
{
   title:"Gaming",
   list: [
      "yay -S heroic-games-launcher-bin wine startwine lutris gamescope mangohud gamemode polymc",
   ]
}]

function build(building) {
   console.log("Start buildinig...");
   let container = getContainer();
   if (container == null || container == undefined) {
      createContainer();
      container = getContainer();
   }
   for (const i in building){
      const brick = building[i]
      let a = document.createElement("a")
      a.innerHTML = brick.title
      a.setAttribute("href", `#${brick.title}`)
      container.appendChild(a);
   }
   for (const i in building){
      const brick = building[i]
      let titleElement = document.createElement("h1")
      titleElement.innerHTML = brick.title
      titleElement.setAttribute("id", `${brick.title}`)
      let listElement = document.createElement("ul")
      listElement.setAttribute("class", "list")
      for (const j in brick.list) {
         let liElement = document.createElement("li")
         liElement.innerHTML = brick.list[j]
         listElement.appendChild(liElement)
      }
      container.appendChild(titleElement)
      container.appendChild(listElement)
   }
}

function getContainer() {
   return document.querySelector(".container")
}

function createContainer() {
   let container = document.createElement("div")
   container.setAttribute("class", "container")
   document.body.appendChild(container)
}

function updateHeader(title) {
   document.title = title
}

updateHeader("ArchLinux configuration!")
build(buildingInterface)
setTimeout(() => {
   document.body.style.backgroundColor = "rgba(0,0,0,0.1)"
},100)