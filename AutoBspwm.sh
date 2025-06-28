#!/bin/bash

# Colours d
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n${redColour}[!] Saliendo del programa...${endColour}\n"
  tput cnorm && exit 1
}

trap ctrl_c INT


# Variables globales
user="$(whoami)"
home="/home/$user"

Dow_es="$home/Descargas"
Dow_en="$home/Downloads"
Dow=""
Desk="$home/Desktop"

status="0"
temp_status="0"

# Funciones

function move_to_desktop(){
  if [ -d $Desk ]; then
    cd $Desk
  else
   echo -e "\n${redColour}[+] El programa está definido para trabajar con los directorios de un sistema en inglés o español, tu sistema debe estar en otro idioma y por ello no es posible utilizar este script.${endColour}"
      tput cnorm; exit 1
    fi
}


function move_to_downloads(){
  if [ -d $Dow_en ]; then
    cd $Dow_en
    Dow="$Dow_en"
  elif [ -d $Dow_es ]; then
    cd $Dow_es
    Dow="$Dow_es"
  else
    echo -e "\n${redColour}[+] El programa está definido para trabajar con los directorios de un sistema en inglés o español, tu sistema debe estar en otro idioma y por ello no es posible utilizar este script.${endColour}"
      tput cnorm; exit 1
  fi
}

function save_status(){
  status_aux="$1"
  
  if [ ! "$status_aux" -eq "0" ]; then
    status="$1"
  fi
}

function check_status(){
  status="$1"
  greenText="$2"
  redText="$3"

  if [ "$status" == 0 ]; then
    echo -e "${yellowColour}[+]${endColour} ${greenColour}${greenText}${endColour}"
  else
    echo -e "\n${redColour}[+] ${redText}${endColour}\n"
    tput cnorm; exit 1
   fi

}

function update_upgrade(){

  move_to_downloads
  system="$(echo $1 | tr '[:upper:]' '[:lower:]')"

  if [ "$system" == "parrot" ]; then
    echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Actualizando el sistema parrot...${endColour}"
    (sudo apt update) &>/dev/null && (sudo parrot-upgrade) &>/dev/null
    save_status "$(echo $?)"
  elif [ "$system" == "arch" ]; then
    echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Actualizando el sistema ArchLinux...${endColour}"
    (sudo pacman -Syu) &>/dev/null
    save_status "$(echo $?)"
  else
    echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Actualizando el sistema...${endColour}"
    if [ "$(cat "/etc/apt/sources.list" | wc -l)" -gt "3"  ]; then
      if [ ! "$(cat "/etc/apt/sources.list" | grep -i "debian")" ]; then
        cat /etc/apt/sources.list | tee repo_info &>/dev/null
        echo "" >> repo_info
        echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" >> repo_info
        echo "deb-src http://deb.debian.org/debian/ bullseye main contrib non-free" >> repo_info
        cat repo_info | sudo mv -f repo_info /etc/apt/sources.list &>/dev/null
      fi
    fi
    (sudo apt update) &>/dev/null && (sudo apt upgrade -y) &>/dev/null
    save_status "$(echo $?)"
  fi
  
}

function services_arch(){
  # For automatically launching mpd on login
  systemctl --user enable mpd.service &>/dev/null
  systemctl --user start mpd.service &>/dev/null

  # For charger plug/unplug events (if you have a battery)
  sudo systemctl enable acpid.service &>/dev/null
  sudo systemctl start acpid.service &>/dev/null
}

function install_arch_packages(){
  	echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando los paquetes necesarios...${endColour}"
	(sudo pacman -S bspwm kitty neovim git base-devel wget dpkg neovim zsh --needed --noconfirm) &>/dev/null

	yayu=$(which yay 2>/dev/null)
	paruu=$(which paru 2>/dev/null)

	if [ "$paruu" ]; then
		(paru -Sy awesome-git picom-git alacritty rofi todo-bin acpi acpid wireless_tools jq inotify-tools polkit-gnome xdotool xclip maim brightnessctl alsa-utils alsa-tools lm_sensors mpd mpc mpdris2 ncmpcpp playerctl moreutils --needed --noconfirm) &>/dev/null
		save_status "$(echo $?)"
        services_arch
	elif [ "$yayu" ]; then
		(yay -Sy awesome-git picom-git alacritty rofi todo-bin acpi acpid wireless_tools jq inotify-tools polkit-gnome xdotool xclip maim brightnessctl alsa-utils alsa-tools lm_sensors mpd mpc mpdris2 ncmpcpp playerctl moreutils --needed --noconfirm) &>/dev/null
		save_status "$(echo $?)"
        services_arch
	else
		echo -e "\n${yellowColour}Es necesario tener instalado un AUR helper como YAY o PARU.${endColour}\n"
		exit
	fi
}

function install_packages(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando los paquetes necesarios...${endColour}"

  (sudo apt install bspwm build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev moreutils curl net-tools -y) &>/dev/null
  save_status "$(echo $?)"

  (sudo apt install cmake libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev zsh rofi polybar kitty imagemagick feh locate i3lock neovim -y) &>/dev/null
  save_status "$(echo $?)"

  (sudo apt update) &>/dev/null
  save_status "$(echo $?)"
}

function bspwm_sxhkd(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando y configurando Bspwm y Sxhkd...${endColour}"
  move_to_downloads

  git clone https://github.com/baskerville/bspwm.git &>/dev/null
  save_status "$(echo $?)"
  
  git clone https://github.com/baskerville/sxhkd.git &>/dev/null
  save_status "$(echo $?)"
  
  cd bspwm
  make &>/dev/null
  sudo make install &>/dev/null

  cd ..
  cd sxhkd
  make &>/dev/null
  sudo make install &>/dev/null

  cd ..
  cp -rf ./AutoBspwm/.config/bspwm $home/.config &>/dev/null
  save_status "$(echo $?)"
  cp -rf ./AutoBspwm/.config/sxhkd $home/.config &>/dev/null
  save_status "$(echo $?)"

  cp -rf ./AutoBspwm/.config/bin $home/.config &>/dev/null
  save_status "$(echo $?)"

  cp -rf ./AutoBspwm/content/Fondos $home/Desktop &>/dev/null
  save_status "$(echo $?)"

  # Required instuctions for bspwmrc
  cat $home/.config/bspwm/bspwmrc | sed "s/sammy/$user/g" | sponge $home/.config/bspwm/bspwmrc
  save_status "$(echo $?)"


  # Required instructions for scripts
  cat ~/.config/bspwm/scripts/target_to_hack.sh | sed "s/sammy/$user/g" | sponge ~/.config/bspwm/scripts/target_to_hack.sh 
  save_status "$(echo $?)"

  # Required instructions for sxhkdrc
  cat $home/.config/sxhkd/sxhkdrc | sed "s/sammy/$user/g" | sponge $home/.config/sxhkd/sxhkdrc
  save_status "$(echo $?)"

  move_to_downloads
  sudo rm -rf bspwm sxhkd
}

function kitty(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Actualizando la kitty...${endColour}"

  cd

  (curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n) &>/dev/null
  save_status "$(echo $?)"

  if [ -d /opt/kitty ]; then
    sudo rm -rf /opt/kitty &>/dev/null
  fi
  sudo mv -f "$home/.local/kitty.app" /opt/kitty &>/dev/null
  save_status "$(echo $?)"

  sudo chmod +rx /opt/kitty &>/dev/null
  save_status "$(echo $?)"
  cd

  (sudo apt remove kitty -y) &>/dev/null

  move_to_downloads

  cp -rf ./AutoBspwm/.config/kitty $home/.config &>/dev/null
  save_status "$(echo $?)"
  sudo cp -rf ./AutoBspwm/.config/kitty /root/.config &>/dev/null
  save_status "$(echo $?)"

}

function polybar(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando y configurando la polybar...${endColour}"
  move_to_downloads

  cd ./AutoBspwm/content/blue-sky/polybar
  save_status "$(echo $?)"
  
  # fonts
  if [ "$1" == "arch" ]; then
    sudo cp -f ./fonts/* /usr/share/fonts/ &>/dev/null
  else
    sudo cp -f ./fonts/* /usr/share/fonts/truetype/ &>/dev/null
  fi
  save_status "$(echo $?)"
  if [ "$1" == "arch" ]; then
    cd /usr/share/fonts &>/dev/null
  else
    cd /usr/local/share/fonts &>/dev/null
  fi
  save_status "$(echo $?)"
  sudo cp -f $Dow/AutoBspwm/.config/fonts/Hack.zip . &>/dev/null
  save_status "$(echo $?)"
  sudo unzip -o -X Hack.zip &>/dev/null
  save_status "$(echo $?)"
  sudo rm -f Hack.zip &>/dev/null
  save_status "$(echo $?)"

  move_to_downloads
  cp -rf ./AutoBspwm/.config/polybar ~/.config &>/dev/null
  save_status "$(echo $?)"

  (fc-cache -v) &>/dev/null
  save_status "$(echo $?)"

  move_to_downloads
  sudo rm -rf blue-sky

}

function picom(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando y configurando picom...${endColour}"
  move_to_downloads

  (git clone https://github.com/yshui/picom.git) &>/dev/null
  save_status "$(echo $?)"
  cd picom
  (meson setup --buildtype=release build) &>/dev/null
  save_status "$(echo $?)"
  (ninja -C build) &>/dev/null
  save_status "$(echo $?)"
  (sudo ninja -C build install) &>/dev/null
  save_status "$(echo $?)"
  
  move_to_downloads

  sudo rm -rf picom
  cp -rf ./AutoBspwm/.config/picom "$home/.config/" &>/dev/null
  save_status "$(echo $?)"

}

function rofi(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Configurando el lanzador de aplicaciones rofi...${endColour}"
  move_to_downloads

  sudo cp -rf ./AutoBspwm/content/rofi-themes-collection /opt &>/dev/null
  save_status "$(echo $?)"
  cp -rf ./AutoBspwm/.config/rofi ~/.config &>/dev/null
  save_status "$(echo $?)"

  (cat ~/.config/rofi/config.rasi | sed "s/sammy/$user/g" | sponge ~/.config/rofi/config.rasi) &>/dev/null
  save_status "$(echo $?)"
}

function zsh(){

  # PENDING: zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting 
  
  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Configurando la zsh...${endColour}"
  move_to_downloads
  (git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k) &>/dev/null

  cp -f ./AutoBspwm/content/.zshrc ~/.zshrc &>/dev/null
  save_status "$(echo $?)"

  cp -f ./AutoBspwm/content/.p10k.zsh ~/.p10k.zsh &>/dev/null
  save_status "$(echo $?)"

  sudo cp -f ./AutoBspwm/content/.p10k.zshr /root/.p10k.zsh &>/dev/null
  save_status "$(echo $?)"

  (sudo ln -s -f "$home/.zshrc" /root/.zshrc) &>/dev/null
  save_status "$(echo $?)"

  sudo chown root:root "/usr/local/share/zsh/site-functions/_bspc" &>/dev/null
  save_status "$(echo $?)"
  

  cd
  (cat ~/.zshrc | sed "s/sammy/$user/g" | sponge ~/.zshrc) &>/dev/null
  save_status "$(echo $?)"
 
  move_to_downloads

 (sudo cp -rf ./AutoBspwm/content/zsh-plugins/zsh-autocomplete /usr/share) &>/dev/null
  save_status "$(echo $?)"
 
 (sudo cp -rf ./AutoBspwm/content/zsh-plugins/zsh-autosuggestions /usr/share) &>/dev/null
  save_status "$(echo $?)"

 (sudo cp -rf ./AutoBspwm/content/zsh-plugins/zsh-syntax-highlighting /usr/share) &>/dev/null
  save_status "$(echo $?)"

 (sudo cp -rf ./AutoBspwm/content/zsh-plugins/zsh-sudo /usr/share) &>/dev/null
  save_status "$(echo $?)"
}

function batcat_lsd(){
  
  move_to_downloads
  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando batcat v0.24.0 y lsd v1.1.5...${endColour}"

  (wget "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb") &>/dev/null
  save_status "$(echo $?)"

  sudo dpkg -i "bat_0.24.0_amd64.deb" &>/dev/null
  save_status "$(echo $?)"
  rm -rf "bat_0.24.0_amd64.deb" &>/dev/null

  (wget "https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd_1.1.5_amd64.deb") &>/dev/null
  save_status "$(echo $?)"

  sudo dpkg -i "lsd_1.1.5_amd64.deb" &>/dev/null
  save_status "$(echo $?)"
  rm -rf "lsd_1.1.5_amd64.deb" &>/dev/null
}

function BurpSuite(){
  
  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Configurando burpsuite...${endColour}"

  move_to_downloads
  (sudo cp -f ./AutoBspwm/content/launchers/burpsuite-launcher /usr/bin/burpsuite-launcher) &>/dev/null
  (sudo chmod 755 /usr/bin/burpsuite-launcher) &>/dev/null
}

function fzf(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando fzf...${endColour}"
  cd
  (git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf) &>/dev/null
  yes | ~/.fzf/install &>/dev/null
  save_status "$(echo $?)"

}

function neovim(){
  
  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Configurando Neovim con NVChad...${endColour}"

  if [ -d  "/home/$user/.config/nvim" ]; then
    rm -rf "/home/$user/.config/nvim" &>/dev/null
  fi

  if [ -d "/root/.config/nvim" ]; then
    sudo rm -rf /root/.config/nvim &>/dev/null
  fi
  git clone https://github.com/NvChad/starter "/home/$user/.config/nvim" &>/dev/null
  save_status "$(echo $?)"
  sudo git clone https://github.com/NvChad/starter /root/.config/nvim &>/dev/null
  save_status "$(echo $?)"
}

function i3lock-fancy(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Instalando y configurando i3lock-fancy para el bloqueo de pantalla...${endColour}"
  move_to_downloads
  (git clone https://github.com/meskarune/i3lock-fancy.git) &>/dev/null
  save_status "$(echo $?)"
  cd i3lock-fancy && (sudo make install) &>/dev/null
  save_status "$(echo $?)"

  move_to_downloads
  sudo rm -rf i3lock-fancy &>/dev/null
}

function check_temp(){
  if [ ! "$1" -eq 0 ]; then
    temp_status="$1"
  fi
}

function obsidian(){
  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Descargando e instalando obsidian...${endColour}"

  temp_status="0"

  move_to_downloads && cd AutoBspwm/content &>/dev/null
  check_temp "$(echo "$?")"
  mkdir obsidian &>/dev/null
  check_temp "$(echo "$?")"
  cd obsidian &>/dev/null
  check_temp "$(echo "$?")"
  
  wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.5/Obsidian-1.7.5.AppImage &>/dev/null
  if [ ! "$(echo $?)" -eq 0 ]; then
    echo -e "\n${yellowColour}[!] Error con la descarga de Obsidian.${endColour}\n"
  fi
  chmod +x Obsidian-1.7.5.AppImage &>/dev/null
  check_temp "$(echo "$?")"
  mv Obsidian-1.7.5.AppImage Obsidian.AppImage &>/dev/null
  check_temp "$(echo "$?")"
  move_to_downloads
  sudo cp -rf ./AutoBspwm/content/obsidian /opt &>/dev/null
  check_temp "$(echo "$?")"

  sudo cp -f ./AutoBspwm/content/launchers/obsidian-launcher /usr/bin/ &>/dev/null
  check_temp "$(echo "$?")"
  cd /usr/bin &>/dev/null
  check_temp "$(echo "$?")"
  sudo chmod 755 obsidian-launcher &>/dev/null
  check_temp "$(echo "$?")"
  cd
  if [ ! "$temp_status" -eq 0 ]; then
    echo -e "${yellowColour}[!] Eror al instalar obsidian.${endColour}"
  else
    echo -e "${yellowColour}[+]${endColour} ${greenColour}Obsidian se ha instalado correctamente.${endColour}"
  fi
}

function mullvad(){

  temp_status="0"

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Descargando e instalando mullvad browser...${endColour}"
  move_to_downloads && cd AutoBspwm/content
  check_temp "$(echo "$?")"
  if [ -d mullvad-browser ]; then
    rm -rf mullvad-browser
  fi
  wget https://mullvad.net/en/download/browser/linux-x86_64/latest &>/dev/null
  if [ ! "$(echo $?)" -eq 0 ]; then
    echo -e "\n${yellowColour}[!] Error con la descarga de Mullvad.${endColour}"
  fi


  7z x latest &>/dev/null
  check_temp "$(echo "$?")"
  rm -f latest &>/dev/null
  check_temp "$(echo "$?")"
  7z x latest~ &>/dev/null
  check_temp "$(echo "$?")"
  rm -f latest~ &>/dev/null
  check_temp "$(echo "$?")"

  sudo cp -rf mullvad-browser /opt &>/dev/null
  check_temp "$(echo "$?")"
  sudo chmod -R 775 /opt/mullvad-browser &>/dev/null
  check_temp "$(echo "$?")"
  sudo chown -R root:$user /opt/mullvad-browser &>/dev/null
  check_temp "$(echo "$?")"
  sudo cp -f ./launchers/mullvad-launcher /usr/bin &>/dev/null
  check_temp "$(echo "$?")"
  sudo chmod +x /usr/bin/mullvad-launcher
  check_temp "$(echo "$?")"

  rm -rf mullvad-browser &>/dev/null
  check_temp "$(echo "$?")"

  if [ ! "$temp_status" -eq 0 ]; then
    echo -e "${yellowColour}[!] Eror al instalar mullvad browser.${endColour}"
  else
    echo -e "${yellowColour}[+]${endColour} ${greenColour}Mullvad browser se ha instalado correctamente.${endColour}"
  fi
}

function shell(){

  echo -e "\n${yellowColour}[+]${endColour} ${blueColour}Configurando la Shell zsh como principal...${endColour}"
  sudo usermod --shell /usr/bin/zsh root &>/dev/null
  save_status "$(echo $?)"
  sudo usermod --shell /usr/bin/zsh "$user" &>/dev/null
  save_status "$(echo $?)"
}

function root_checker(){
  suid="$(id | grep "uid=0")"

  if [ "$suid" ]; then
    echo -e "\n${redColour}[+]${endColour} ${blueColour}Actualmente, se encuentra como usuario root, ejecute el programa como usuario no privilegiado.${endColour}\n"
    tput cnorm; exit 1
    return 0
  fi
  return 0
}

function pwd_check(){

  if [ "$(pwd)" == "$home/Downloads/AutoBspwm" ] || [ "$(pwd)" == "$home/Descargas/AutoBspwm" ]; then
    return 0
  else
    return 1
  fi
}

# Funcion principal (Main)

function main(){
  tput civis

  echo ""
  echo "▄████▄░██░░░██░████████░▄█████▄░█████▄░▄██████░█████▄░██░██░██░▄██▄▄██▄
██░░██░██░░░██░░░░██░░░░██░░░██░██░░██░██░░░░░░██░░██░██░██░██░██░██░██
██░░██░██░░░██░░░░██░░░░██░░░██░█████░░▀█████▄░█████▀░██░██░██░██░██░██
██████░██░░░██░░░░██░░░░██░░░██░██░░██░░░░░░██░██░░░░░██░██░██░██░██░██
██░░██░▀█████▀░░░░██░░░░▀█████▀░█████▀░██████▀░██░░░░░▀██▀▀██▀░██░██░██
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
  echo -e "${grayColour}𝑀𝑎𝑑𝑒 𝑏𝑦 𝑠𝑎𝑚𝑚𝑦-𝑢𝑙𝑓ℎ${endColour}"
  echo ""
  
  root_checker
  check_status "$(echo $?)" "Se ha realizado la comprobación del programa para continuar su ejecución como usuario no privilegiado." "Algo ha salido mal durante la comprobación del suid, inténtelo de nuevo."

  echo ""
  pwd_check
  check_status "$(echo $?)" "Se ha realizado la comprobación del directorio." "Mueva el directorio AutoBspwm a la carpeta de descargas y/o ejecute el script dentro del mismo directorio AutoBspwm."

  if [ "$(cat "/etc/os-release" | grep -i "parrot")" ]; then
    update_upgrade "parrot"
    system="parrot"
  elif [ "$(cat "/etc/os-release" | grep -i "arch")" ]; then
    update_upgrade "arch"
    system="arch"
  else
    update_upgrade
  fi
  check_status "$status" "Todo se ha actualizado correctamente." "Algo ha salido mal durante la actualización, inténtelo de nuevo."

  if [ "$system" == "arch" ]; then
	install_arch_packages
  else
  	install_packages
  fi
  check_status "$status" "Los paquetes se han instalado y actualizado correctamente." "Algo ha salido mal durante la instalación y actualización de los paquetes, inténtelo de nuevo."

  bspwm_sxhkd
  check_status "$status" "Bspwm y Sxhkd se han instalado y configurado correctamente." "Algo ha salido mal mientras se instalaba y configuraba Bspwm y Sxhkd, inténtelo de nuevo." 

  kitty
  check_status "$status" "La kitty se ha actualizado correctamente." "Algo ha salido mal mientras se actualizaba la kitty, inténtelo de nuevo."

  polybar "$system"
  check_status "$status" "La polybar se ha instalado y configurado correctamente." "Algo ha salido mal mientras se instalaba y configuraba la polybar, inténtelo de nuevo."

  picom
  check_status "$status" "Picom se ha instalado y configurado correctamente." "Algo ha salido mal mientras se instalaba y configuraba picom, inténtelo de nuevo."

  rofi
  check_status "$status" "Rofi se ha configurado correctamente." "Algo ha salido mal mientras se configuraba rofi, inténtelo de nuevo."

  zsh
  check_status "$status" "La zsh se ha configurado correctamente." "Algo ha salido mal mientras se configuraba la zsh, inténtelo de nuevo."

  batcat_lsd
  check_status "$status" "Batcat y Lsd se han instalado y configurado correctamente." "Algo ha salido mal mientras se instalaba y configuraba Batcat y Lsd, inténtelo de nuevo."

  BurpSuite
  check_status "$status" "Burpsuite se ha configurado correctamente." "Algo ha salido mal mientras se configuraba Burpsuite, inténtelo de nuevo."
 
  neovim
  check_status "$status" "Neovim se ha configurado correctamente." "Algo ha salido mal mientras se configuraba Neovim, inténtelo de nuevo."

  i3lock-fancy
  check_status "$status" "i3lock-fancy se ha instalado y configurado correctamente." "Algo ha salido mal mientras se instalaba y configuraba i3lock-fancy, inténtelo de nuevo."

  obsidian

  mullvad

  shell
  check_status "$status" "El tipo de shell se ha configurado correctamente." "Algo ha salido mal mientras se configuraba el tipo de shell, inténtelo de nuevo."
  fzf
  check_status "$status" "fzf se ha instalado correctamente." "Algo ha salido mal con fzf, ejecute el comando kill -9 -1, cambie a bspwm e intentelo manualmente."

  if [ "$(cat "/etc/os-release" | grep -i "parrot")" ]; then
    update_upgrade "parrot" 
  elif [ "$(cat "/etc/os-release" | grep -i "arch")" ]; then
    update_upgrade "arch" 
  else
    update_upgrade
  fi
  tput cnorm
  check_status "$status" "Todo se ha todo se ha concluido correctamente, ejecute el comando \"kill -9 -1\" y seleccione el entorno de bspwm." "Algo ha salido mal durante la última actualización. Ejecute el comando \"kill -9 -1\", seleccione el entorno de bspwm e intentelo manualmente."
}


main
