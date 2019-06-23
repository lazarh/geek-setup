#!/bin/sh

cd ~

sudo apt update
sudo apt --fix-broken install -y
sudo apt install vim git xorg xserver-xorg x11-xserver-utils libx11-dev libxft-dev libxinerama-dev libwebkitgtk-3.0 libwebkitgtk-3.0-dev libasound2-dev feh sxiv libgcr-3-dev x11-utils mpd ncmpcpp libjavascriptcoregtk-3.0-0 libxss1 suckless-tools -y 

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

sudo apt-get source dwm 
rm dwm*.tar.gz dwm&.dsc -f
mv dwm-* dwm
sudo chown def:def dwm

sudo apt-get source dmenu 
rm dmenu*.tar.gz dmenu&.dsc -f
mv dmenu-* dmenu
sudo chown def:def dmenu

sudo apt-get source st
rm st*.tar.gz st&.dsc -f
mv st-* st
sudo chown def:def st

sudo apt-get source surf 
rm surf*.tar.gz surf&.dsc -f
mv surf-* surf
sudo chown def:def surf

sudo apt-get source slstatus 
rm slstatus*.tar.gz slstatus&.dsc -f
mv slstatus-* surf
sudo chown def:def slstatus

#git clone https://git.suckless.org/dwm
#git clone https://git.suckless.org/slstatus
#git clone https://git.suckless.org/st
#git clone https://git.suckless.org/surf
#git clone https://git.suckless.org/dmenu

cp -rf ~/Documents/geek-setup/*dwm*.diff ~/Documents/dwm/.
cp -rf ~/Documents/geek-setup/*slstatus*.diff ~/Documents/slstatus/.
cp -rf ~/Documents/geek-setup/*st*.diff ~/Documents/st/.
cp -rf ~/Documents/geek-setup/*surf*.diff ~/Documents/surf/.

cd ~/Documents/dwm/ 
git apply *lazarh*.diff 
sudo make clean install > /tmp/dwm_build.log 

cd ~/Documents/slstatus
git apply *lazarh*.diff
sudo make clean install > /tmp/slstatus_build.log 

cd ~/Documents/st
git apply *lazarh*.diff
sudo make clean install > /tmp/st_build.log 

cd ~/Documents/surf
git apply *lazarh*.diff
sudo make clean install > /tmp/surf_build.log 

cd ~
startx
