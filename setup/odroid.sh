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
sudo apt-get -y install samba samba-common-bin netatalk
sudo apt-get -y install -y python3 python3-dev python3-pip odroid-wiringpi libwiringpi-dev
sudo systemctl enable smbd.service

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
#{"AccountTag":"b0ac0ef3731ea4941b313c4996abc32b","TunnelSecret":"iZvrwta8RIeZ1KIdhGbNymLfOPo6ixj8deNsPKgi/X4=","TunnelID":"0a59bdcf-8dcd-40a5-8425-587ef43bb236","TunnelName":"odroid"}
#cloudflared tunnel create odroid
#cloudflared tunnel route dns 0a59bdcf-8dcd-40a5-8425-587ef43bb236 hub.snjallingur.is
# Added CNAME hub.snjallingur.is

sudo add-apt-repository -y ppa:hardkernel/ppa

sudo groupadd i2c
sudo useradd -rm homeassistant -G dialout,i2c
sudo gpasswd -a homeassistant dialout



#mysql setup
sudo mysql -u root -p
#Create Database Homeassistant;
#CREATE USER 'homeassistant' IDENTIFIED BY 'snjallingur';
#use mysql;
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


#Install NodeJS
wget https://nodejs.org/dist/v15.14.0/node-v15.14.0-linux-arm64.tar.xz
tar -xf node-v15.14.0-linux-arm64.tar.xz
cd node-v15.14.0-linux-arm64
sudo cp -R * /usr/local/
#install Code Server
curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@homeassistant

sudo adduser snjallingur

#act as Homeassistant user
sudo -u homeassistant -H -s
cd /home/homeassistant
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
python3.8 -m pip install -U --user pip Odroid.GPIO
python3.8 -m pip install wheel setuptools 
python3.8 -m pip install BeautifulSoup4 lxml bs4 requests paho-mqtt pypi DateTime
pip install google-cloud google-cloud-storage pycurl mysql-connector-python numpy imutils pymysql mysql
#create acount key file through console and downlaod it from there
gcloud iam service-accounts keys create google_service_account.json --iam-account=snjallingurhub@snjallingur-313312.iam.gserviceaccount.com
/home/homeassistant/.pyenv/versions/3.8.7/bin/gsutil config -e

#install Homeassistant
#sudo -u homeassistant -H -s
cd /srv/homeassistant
/home/homeassistant/.pyenv/shims/python3.8 -m venv .
#python3.8 -m venv .
source /srv/homeassistant/bin/activate
/home/homeassistant/.local/bin/pip3.8 install wheel
/home/homeassistant/.local/bin/pip3.8 install requests
pip install aiohttp
pip install mysqlclient
pip install homeassistant==2021.8.8
#install HACS
wget -q -O - https://install.hacs.xyz | bash -
