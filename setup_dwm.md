### Packages

apt install xorg tmux mc libx11-dev libxft-dev libxinerama-dev firefox git ntp vim gstreamer1.0-libav libwebkit2gtk-4.0-37 libwebkit2gtk-4.0-dev libasound2-dev upower
pkg-config libncursesw5-dev libreadline6-dev

### Sources

DWM
```
git clone https://git.suckless.org/dwm

patch
22c22
< static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
---
> static const char *tags[] = { "1", "2", "3", "4", "5" };
47c47
< #define MODKEY Mod1Mask
---
> #define MODKEY Mod4Mask
60a61
> static const char *firefox[]  = { "firefox", NULL };
65a67
>       { MODKEY|ShiftMask,             XK_f,      spawn,          {.v = firefox } },
```

STterm
```
git clone https://git.suckless.org/stterm

patch
8c8
< static char *font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";
---
> static char *font = "Liberation Mono:pixelsize=14:antialias=true:autohint=true";
```

Surf
```
git clone https://git.suckless.org/surf

patch
```

DMenu
```
git clone https://git.suckless.org/dmenu
```

SLStatus
```
git clone https://git.suckless.org/slstatus

patch
66c66,70
<       { datetime, "%s",           "%F %T" },
---
>       { disk_free, "%s ",             "/" },
>       { load_avg, "%s ",              "" },
>       { battery_perc, "%s%% ",        "battery" },
>       { keymap, "%s ",                ""      },
>       { datetime, "%s",               "%F %T" },
```

NNN
```
wget https://github.com/jarun/nnn/archive/v2.3.tar.gz
tar xvf v2.3.tar.gz
make
sudo make install
```
