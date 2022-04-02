read -p "Enter your name : " myName
read -p "Enter your email : " myEmail

#install NVM
echo installing NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

#Flatpack config
echo adding flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo isntalling flatpacks
flatpak install flathub com.spotify.Client
flatpak install flathub org.videolan.VLC
flatpak install flathub com.discordapp.Discord
flatpak install flathub us.zoom.Zoom
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub org.blender.Blender
flatpak install flathub io.github.liberodark.OpenDrive
flatpak install flathub org.fedoraproject.MediaWriter
flatpak install flathub com.bitwarden.desktop

#Brave Browser
echo installing Brave
sudo dnf install dnf-plugins-core

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser

#Codium
echo installing Codium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium

#Fonts
echo Downloading Fonts
   curl -fLo "SpaceMonoNerdFontComplete.otf" \
    https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Regular/complete/Space%20Mono%20Nerd%20Font%20Complete%20Mono.ttf
sudo mkdir /usr/share/fonts/SpaceMono2
sudo cp ~/SpaceMonoNerdFontComplete.otf /usr/share/fonts/SpaceMono2
rm ~/SpaceMonoNerdFontComplete.otf
sudo fc-cache -v
echo font added and cache cleared

#Syncthing
echo isntalling syncthing
sudo dnf install syncthing

#Git Identity
echo Adding git identity
git config --global user.name "$myName"
git config --global user.email $myEmail


# create a new ssh key
echo Generating SSH Keys
ssh-keygen -t ed25519 -C "$myEmail"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo Copy this SSH Key
cat ~/.ssh/id_ed25519.pub