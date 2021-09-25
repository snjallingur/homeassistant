#sudo useradd -m -s $(which bash) -G sudo snjallingur
#passwd snjallingur
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install python-pycurl python-pycurl-dbg python-dev python-gobject python-gobject-2 git libdbus-1-dev libdbus-glib-1-dev build-essential libssl-dev libffi-dev python-dev
sudo apt-get -y install libssl-dev libxml2-dev libxslt-dev libcurl4-openssl-dev
sudo apt-get -y install libjpeg-dev libtiff5-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev python3-opencv libatlas-base-dev
sudo apt-get -y install libxml2-utils libssl-doc libcurl4-gnutls-dev 
sudo apt-get -y install apache2 php libapache2-mod-php php-mysql php-curl -y
sudo apt-get -y install libavahi-compat-libdnssd-dev ffmpeg libmosquitto-dev
sudo apt-get -y install pkg-config libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev 
sudo apt-get -y install libasound2-dev dh-autoreconf libortp-dev pulseaudio-module-bluetooth bluez bluetooth bluez-tools libbluetooth-dev libusb-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libsbc1 libsbc-dev libomxil-bellagio-dev
sudo apt-get -y install mosquitto mosquitto-clients
#sudo apt-get -y install samba samba-common-bin netatalk
sudo apt-get -y install -y python3 python3-dev python3-pip odroid-wiringpi libwiringpi-dev
#sudo systemctl enable smbd.service
sudo systemctl disable apache2

#add for services
#StandardOutput=append:/var/log/cloudflared.log
#StandardError=append:/var/log/cloudflared_error.log


sudo apt-get -y install libmariadb-dev-compat libmariadb-dev mariadb-server
sudo apt-get -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
#Install Docker
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

#Install doods 
#docker pull snowzach/doods
#docker run snowzach/doods:latest
#docker stop snowzach/doods:latest

#Install Cloudflared
wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
sudo mv cloudflared /usr/local/bin
sudo chmod +x /usr/local/bin/cloudflared
#cloudflared -v
sudo mkdir /etc/cloudflared
#sudo bash -c 'cat  cloudflare.txt > /etc/cloudflared/config.yml'
sudo cloudflared service install
sudo systemctl enable cloudflared

#Created tunnel odroid with id 0a59bdcf-8dcd-40a5-8425-587ef43bb236
#{"AccountTag":"b0axxxxx","TunnelSecret":"iZvrwxxxxxxxxixj8deNsPKgi/X4=","TunnelID":"0a59bdcxxxxxxxxxxf43bb236","TunnelName":"odroid"}
#cloudflared tunnel create odroid
#cloudflared tunnel route dns 0xxxxxbdcf-8dxxxxxxxxx hub.snjallingur.is
# Added CNAME hub.snjallingur.is

sudo add-apt-repository -y ppa:hardkernel/ppa

sudo groupadd i2c
sudo useradd -rm homeassistant -G dialout,i2c
sudo gpasswd -a homeassistant dialout
#Path for ZHA is /dev/ttyS1



#mysql setup
sudo mysql -u root -p
#Create Database Homeassistant;
#CREATE USER 'homeassistant' IDENTIFIED BY 'snjallingur';
#use mysql;
#FLUSH PRIVILEGES;
#ALTER USER  'root'@'localhost' IDENTIFIED BY 'the-new-password';
#GRANT ALL PRIVILEGES ON Homeassistant.* TO 'homeassistant'@'%' IDENTIFIED BY 'snjallingur';
#GRANT ALL PRIVILEGES ON Homeassistant.* TO 'homeassistant'@'localhost' IDENTIFIED BY 'snjallingur';
#FLUSH PRIVILEGES;

sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant
# Homeassistant Service
sudo bash -c 'cat  homeassistant_service.txt > /etc/systemd/system/home-assistant@homeassistant.service'
#add logging specification
#switch cat >> to cat > to create a file instead of append
# create cron job service files
sudo bash -c 'cat  cron.txt >> /etc/crontab'
sudo systemctl --system daemon-reload
sudo systemctl enable home-assistant@homeassistant
#Usage:
#sudo systemctl restart home-assistant@homeassistant
#sudo systemctl stop home-assistant@homeassistant
#sudo systemctl status home-assistant@homeassistant
#sudo journalctl -f -u home-assistant@homeassistant
#sudo journalctl -f -u home-assistant@homeassistant | grep -i 'error'
#sudo systemctl start home-assistant@homeassistant
sudo systemctl enable --now code-server@homeassistant
sudo systemctl --system daemon-reload

#Install NodeJS
wget https://nodejs.org/dist/v15.14.0/node-v15.14.0-linux-arm64.tar.xz
tar -xf node-v15.14.0-linux-arm64.tar.xz
cd node-v15.14.0-linux-arm64
sudo cp -R * /usr/local/
cd ..
#install Code Server
curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@homeassistant
#start the code-server manually 
#sudo service code-server@homeassistant start
#amend /home/homeassistant/.config/code-server/config.yml
#bind-addr: 0.0.0.0:8080
#auth: password
#password: snjallingur             
#cert: false


#act as Homeassistant user
sudo -u homeassistant -H -s
cd /home/homeassistant
#install pyenv
curl https://pyenv.run | bash
cat >> /home/homeassistant/.bashrc <<'EOF'
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv virtualenv-init -)"
EOF
source /home/homeassistant/.bashrc
pyenv install -v 3.8.10
pyenv global 3.8.10
#pip install BeautifulSoup4 lxml bs4 requests paho-mqtt pypi DateTime
#pip install google-cloud google-cloud-storage pycurl mysql-connector-python numpy imutils pymysql mysql
/home/homeassistant/.pyenv/versions/3.8.10/bin/python3.8 -m pip install -U --user pip Odroid.GPIO
/home/homeassistant/.pyenv/versions/3.8.10/bin/python3.8 -m pip install wheel setuptools BeautifulSoup4 lxml bs4 requests paho-mqtt pypi DateTime 
/home/homeassistant/.pyenv/versions/3.8.10/bin/python3.8 -m pip install google-cloud google-cloud-storage pycurl mysql-connector-python numpy imutils pymysql mysql gsutil
/home/homeassistant/.pyenv/versions/3.8.10/bin/gsutil config -e

#/home/homeassistant/.pyenv/versions/3.8.10/bin/gsutil -m rsync -r -x ".*\.db|.*\.jpg|.*\.log" /home/homeassistant/.homeassistant gs://snjallingur_hub/homeassistant
#Restore
#/home/homeassistant/.pyenv/versions/3.8.10/bin/gsutil -m rsync -r -x ".*\.db|.*\.jpg|.*\.log" gs://snjallingur_hub/homeassistant /home/homeassistant/.homeassistant 
#create acount key file through console and downlaod it from there
#gcloud iam service-accounts keys create google_service_account.json --iam-account=snjallingurhub@snjallingur-313312.iam.gserviceaccount.com


#install Homeassistant
#sudo -u homeassistant -H -s
mkdir /home/homeassistant/Videos
cd /srv/homeassistant
/home/homeassistant/.pyenv/shims/python3.8 -m venv .
#python3.8 -m venv .
source /srv/homeassistant/bin/activate
pip3.8 install wheel requests
pip3.8 install install aiohttp mysqlclient
pip3.8 install homeassistant==2021.8.8
#install HACS
wget -q -O - https://install.hacs.xyz | bash -

#setup of WiFi
#instructions: https://wiki.odroid.com/troubleshooting/minimal_image_wifi_setup_nmcli
#nmcli device
#nmcli radio wifi on
#nmcli device wifi list
#sudo nmcli device wifi connect "SSID" password "WiFiPassword"
#Device 'wlan0' successfully activated with '47232814-f545-48eb-a325-0abb94427f0a'
#

