#!/bin/bash

# Cập nhật và cài các gói cần thiết
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies tightvncserver xterm wget git curl supervisor python3-pip

# Cài noVNC
mkdir -p ~/novnc
cd ~/novnc
git clone https://github.com/novnc/noVNC.git
git clone https://github.com/novnc/websockify.git
cd noVNC
git checkout v1.3.0
cd ../websockify
git checkout v0.10.0
cd ~/novnc/noVNC
ln -s ../websockify .

# Cấu hình VNC
vncserver :1
vncserver -kill :1
mkdir -p ~/.vnc
echo "#!/bin/sh
xrdb $HOME/.Xresources
startxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Cài Wine
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine64 wine32

# Tạo script khởi động VNC + noVNC
echo "#!/bin/bash
vncserver :1 -geometry 1280x720 -depth 24
~/novnc/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080" > ~/start-desktop.sh
chmod +x ~/start-desktop.sh
