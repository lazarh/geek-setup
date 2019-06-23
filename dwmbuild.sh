#!/bin/sh

cd ~

sudo apt install git xorg libx11-dev libxft-dev libxinerama-dev vim libwebkit2gtk-4.0-37 libwebkit2gtk-4.0-dev libasound2-dev feh fzy sxiv libgcr-3-dev x11-utils mpd ncmpcpp -y

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

xinitrc=~/.xinitrc2

if [ -e $xinitrc ]; then
	echo "File $xinitrc already exists!"
else
	cat > $xinitrc <<EOF
exec startdwm & slstatus
EOF
fi

mkdir ~/Documents/
cd ~/Documents/

git clone https://github.com/lazarh/geek-setup.git
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/slstatus
git clone https://git.suckless.org/st
git clone https://git.suckless.org/surf
git clone https://git.suckless.org/dmenu

cp ~/Documents/geek-setup/*dwm*.diff ~/Documents/dwm/.
cp ~/Documents/geek-setup/*slstatus*.diff ~/Documents/slstatus/.
cp ~/Documents/geek-setup/*st*.diff ~/Documents/st/.
cp ~/Documents/geek-setup/*surf*.diff ~/Documents/surf/.

cd ~/Documents/dwm/ 
git apply *lazarh*.diff 
sudo make clean install

cd ~/Documents/slstatus
git apply *lazarh*.diff
sudo make clean install

cd ~/Documents/st
git apply *lazarh*.diff
sudo make clean install

cd ~/Documents/surf
git apply *lazarh*.diff
sudo make clean install


