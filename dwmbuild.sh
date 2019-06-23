#!/bin/sh

cd ~

temp_sourceslist=/tmp/sources.list
sourceslist=/etc/apt/sources.list
sourceslistorig=/etc/apt/sources.list.orig
cat > $temp_sourceslist <<EOF
deb http://deb.debian.org/debian/ testing main contrib non-free
#deb-src http://deb.debian.org/debian/ testing main contrib non-free

deb http://deb.debian.org/debian/ testing-updates main contrib non-free
#deb-src http://deb.debian.org/debian/ testing main contrib non-free
EOF

sudo mv $sourceslist $sourceslistorig
sudo cp $temp_sourceslist $sourceslist

sudo apt update
supo apt upgrade -y
sudo apt --fix-broken install -y
sudo apt install vim git xorg xserver-xorg x11-xserver-utils libx11-dev libxft-dev libxinerama-dev libwebkit2gtk-4.0-37 libwebkitgtk2-4.0-dev libasound2-dev feh sxiv libgcr-3-dev x11-utils mpd ncmpcpp libjavascriptcoregtk-4.0-18-dev libxss1 suckless-tools -y 
supo apt upgrade -y

temp_startdwm=/tmp/startdwm
startdwm=/usr/local/bin/startdwm

if [ -e $startdwm ]; then
	echo "File $startdwm already exists!"
else
	cat > $temp_startdwm <<EOF
#!/bin/sh

while true; do
    # Log stderror to a file
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
EOF
	sudo mv $temp_startdwm $startdwm
fi

sudo chmod +x $startdwm

xinitrc=~/.xinitrc

if [ -e $xinitrc ]; then
	echo "File $xinitrc already exists!"
else
	cat > $xinitrc <<EOF
exec startdwm & slstatus
EOF
fi

temp_wallpaper=/tmp/randowwallpaper
randomwallpaper=/usr/local/bin/randomwallpaper

if [ -e $randomwallpaper ]; then
	echo "File $randomwallpaper already exists!"
else
	cat > $temp_wallpaper <<EOF
#!/bin/sh
feh --randomize --bg-fill /home/def/Documents/wallpapers/Landscapes/*
EOF
	sudo mv $temp_wallpaper $randomwallpaper
fi

sudo chmod +x $randomwallpaper

mkdir ~/Documents/ -p
cd ~/Documents/

git clone https://github.com/lazarh/geek-setup.git
git clone https://git.suckless.org/dwm
#git clone --single-branch --branch 6.1 https://git.suckless.org/dwm
git clone https://git.suckless.org/slstatus
git clone https://git.suckless.org/st
git clone https://git.suckless.org/surf
git clone https://git.suckless.org/dmenu
#git clone --single-branch --branch 4.8 https://git.suckless.org/dmenu

cp -rf ~/Documents/geek-setup/dwm*lazarh*.diff ~/Documents/dwm/.
cp -rf ~/Documents/geek-setup/slstatus*lazarh*.diff ~/Documents/slstatus/.
cp -rf ~/Documents/geek-setup/st*lazarh*.diff ~/Documents/st/.
cp -rf ~/Documents/geek-setup/surf*lazarh*.diff ~/Documents/surf/.

cd ~/Documents/dwm/ 
git apply *lazarh*.diff 
sudo make clean install > /tmp/dwm_build.log 

cd ~/Documents/slstatus
git apply *lazarh*.diff
sudo make clean install > /tmp/slstatus_build.log 

#cd ~/Documents/st
#git apply *lazarh*.diff
#sudo make clean install > /tmp/st_build.log 

cd ~/Documents/surf
git apply *lazarh*.diff
sudo make clean install > /tmp/surf_build.log 

cd ~
startx
