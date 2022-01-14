#!/bin/bash
#sudo apt-get update
#sudo apt-get upgrade
sudo apt-get install -y python-certbot-apache python-pycurl python-dev python-gobject python-gobject-2 git libdbus-1-dev libdbus-glib-1-dev build-essential libssl-dev libffi-dev python-dev python3-requests
sudo apt-get install -y libffi-dev libssl-dev libxml2-dev libxslt-dev libcurl4-openssl-dev
sudo apt-get install -y libjpeg-dev libtiff5-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev python3-opencv python3-bs4 libatlas-base-dev
sudo apt-get install -y libavahi-compat-libdnssd-dev ffmpeg git  zip unzip libmosquitto-dev certbot
sudo apt-get install -y libxml2-utils libssl-doc libcurl4-gnutls-dev libmariadb-dev 
sudo apt-get install -y pkg-config libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev 
sudo apt-get install -y libasound2-dev dh-autoreconf libortp-dev pulseaudio-module-bluetooth bluez bluetooth bluez-tools libbluetooth-dev libusb-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libsbc1 libsbc-dev libomxil-bellagio-dev libturbojpeg0
sudo apt-get install -y libxkbfile-dev libsecret-1-dev libjpeg-dev zlib1g-dev
sudo apt-get install -y mosquitto mosquitto-clients
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
sudo apt-get install -y golang cmake python-dev python-setuptools
curl -fsSL https://code-server.dev/install.sh | sh
#for Linux
#wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
#https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.deb
wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz
mkdir argo-tunnel
tar -xvzf cloudflared-stable-linux-arm.tgz -C ./argo-tunnel
cd argo-tunnel
sudo mv cloudflared /usr/local/bin
sudo chmod +x /usr/local/bin/cloudflared
cd ..
sudo useradd -rm homeassistant -G dialout,gpio,i2c
sudo gpasswd -a homeassistant dialout
sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant
# Homeassistant Service
sudo bash -c 'cat  homeassistant_service.txt > /etc/systemd/system/home-assistant@homeassistant.service'
# Code-Server Service
sudo bash -c 'cat  code-server_service.txt > /etc/systemd/system/code-server@homeassistant.service'
# mysql
sudo apt-get install -y libmariadb-dev-compat libmariadb-dev mariadb-server
sudo mysql_secure_installation
#switch cat >> to cat > to create a file instead of append
# create cron job service files
sudo bash -c 'cat  cron.txt >> /etc/crontab'
# htaccess
# sudo nano /var/www/html/.htaccess
# Cloudflared
sudo mkdir /etc/cloudflared
sudo bash -c 'cat  cloudflare.txt > /etc/cloudflared/config.yml'
# reload services and enable them
sudo systemctl enable --now code-server@homeassistant
sudo systemctl enable home-assistant@homeassistant
sudo systemctl --system daemon-reload
#install nodejs
wget https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-armv7l.tar.xz
tar -xf node-v14.16.0-linux-armv7l.tar.xz
cd node-v14.16.0-linux-armv7l
sudo cp -R * /usr/local/
cd ..
#install dlib
#https://lindevs.com/install-precompiled-dlib-on-raspberry-pi/
#act as Homeassistant user
sudo -u homeassistant -H -s
cd /home/homeassistant
#install pyenv
curl https://pyenv.run | bash
cat >> /home/homeassistant/.bashrc <<'EOF'
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
source /home/homeassistant/.bashrc
pyenv install -v 3.10.1
pyenv global 3.10.1
#install Rust for gsutil
#install Python modules
pip install BeautifulSoup4 lxml bs4 requests paho-mqtt pypi DateTime
pip install google-cloud google-cloud-storage pycurl mysql-connector-python numpy imutils pymysql mysql
#install Homeassistant
cd /srv/homeassistant
python -m venv .
source /srv/homeassistant/bin/activate
pip install wheel setuptools mysql-connector-python imutils pymysql mysql RPi.GPIO==0.7.1a4
face-recognition
pip install homeassistant==2021.12.8
#install HACS
wget -q -O - https://install.hacs.xyz | bash -





