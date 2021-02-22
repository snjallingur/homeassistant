#!/bin/bash
#sudo apt-get update
#sudo apt-get upgrade
sudo apt-get install python-certbot-apache python-pycurl python-dev python-gobject python-gobject-2 git libdbus-1-dev libdbus-glib-1-dev build-essential libssl-dev libffi-dev python-dev python3-requests
sudo apt-get install libffi-dev libssl-dev libxml2-dev libxslt-dev libcurl4-openssl-dev
sudo apt-get install libjpeg-dev libtiff5-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev python3-opencv python3-bs4 libatlas-base-dev
sudo apt-get install libavahi-compat-libdnssd-dev ffmpeg git  zip unzip libmosquitto-dev certbot
sudo apt-get install libxml2-utils libssl-doc libcurl4-gnutls-dev libmariadb-dev 
sudo apt-get install pkg-config libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev 
sudo apt-get install libasound2-dev dh-autoreconf libortp-dev pulseaudio-module-bluetooth bluez bluetooth bluez-tools libbluetooth-dev libusb-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libsbc1 libsbc-dev libomxil-bellagio-dev libturbojpeg0
sudo apt-get install libxkbfile-dev libsecret-1-dev libjpeg-dev zlib1g-dev
sudo apt-get install mosquitto mosquitto-clients
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
sudo apt-get install golang
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
sudo mv cloudflared /usr/local/bin
sudo chmod +x /usr/local/bin/cloudflared
curl -fsSL https://code-server.dev/install.sh | sh
sudo useradd -rm homeassistant -G dialout,gpio,i2c
sudo gpasswd -a homeassistant dialout
sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant
# Homeassistant Service
sudo bash -c 'cat  homeassistant_service.txt > /etc/systemd/system/home-assistant@homeassistant.service'
# mysql
sudo apt-get install libmariadb-dev-compat libmariadb-dev mariadb-server
sudo mysql_secure_installation
#switch cat >> to cat > to create a file instead of append
# create cron job service files
sudo bash -c 'cat  cron.txt >> /etc/crontab'
# htaccess
# sudo nano /var/www/html/.htaccess
# Cloudflared
sudo bash -c 'cat  cloudflare.txt > /etc/cloudflared/config.yml'
# reload services and enable them
sudo systemctl enable --now code-server@homeassistant
sudo systemctl enable home-assistant@homeassistant
sudo systemctl --system daemon-reload
#act as Homeassistant user
sudo -u homeassistant -H -s
#install pyenv
curl https://pyenv.run | bash
cat >> /home/homeassistant/.bashrc <<'EOF'
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
source /home/homeassistant/.bashrc
pyenv install -v 3.8.7
pyenv global 3.8.7
#install Python modules
pip install BeautifulSoup4 lxml bs4 requests paho-mqtt pypi DateTime
pip install google-cloud google-cloud-storage pycurl mysql-connector-python-rf mysql-connector-python numpy imutils pymysql mysql
#install Homeassistant
cd /srv/homeassistant
python3.8 -m venv .
source /srv/homeassistant/bin/activate
pip3.8 install wheel setuptools mysql-connector-python numpy imutils pymysql mysql
pip3.8 install mysql-connector-python-rf homeassistant 



