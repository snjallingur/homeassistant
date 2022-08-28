#sudo useradd -m -s $(which bash) -G sudo snjallingur
#passwd snjallingur
#sudo gpasswd -a snjallingur dialout
#sudo chmod 670 /dev/ttyS1
sudo add-apt-repository -y ppa:hardkernel/ppa
sudo apt-get update
sudo apt-get upgrade

#Modify the Kernel loader file
sudo nano /etc/default/flash-kernel
#add security=apparmor
#LINUX_KERNEL_CMDLINE="root=UUID=9ceb92e1-c737-4cfe-8a90-bdad2af420b1 quiet splash security=apparmor"
#update boot file
sudo update-bootscript

sudo apt-get -y install jq wget curl avahi-daemon udisks2 libglib2.0-bin network-manager dbus apparmor -y
sudo apt-get -y install libwiringpi-dev
sudo groupadd i2cc
sudo gpasswd -a snjallingur dialout
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release pkg-config build-essential libgpiod-dev
sudo apt-get -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
sudo apt-get -y install -y python3 python3-dev python3-pip odroid-wiringpi libwiringpi-dev cgroup-tools zlib1g-dev udisks2 libglib2.0-bin avahi-daemon jq network-manager dbus apparmor
sudo apt-get -y install libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo apt --fix-broken install
sudo reboot
#Docker installation
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
curl -fsSL get.docker.com | sh

sudo usermod -aG docker snjallingur

#change resolve.conf
sudo nano /etc/resolv.conf
#nameserver 8.8.8.8

#Installing Hass OS agent
wget https://github.com/home-assistant/os-agent/releases/download/1.3.0/os-agent_1.3.0_linux_aarch64.deb
sudo dpkg -i os-agent_1.3.0_linux_aarch64.deb
#check output of
gdbus introspect --system --dest io.hass.os --object-path /io/hass/os

#Installing pyenv guidelines
#https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/

#Installing Supervisor guidelines
#https://peyanski.com/how-to-install-home-assistant-supervised-official-way/
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
sudo dpkg -i homeassistant-supervised.deb

#Installing Zerotier
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
#join Zerotier network
#zerotier-cli join xxxxxxxxx
#remove a zerotier connection
#sudo service zerotier-one stop
#sudo rm /var/lib/zerotier-one/identity.*
#sudo service zerotier-one start

#CLoudflared
#cloudflared tunnel route dns xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx demo.snjallingur.is
#sudo nano /etc/cloudflared/config.yml
wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
sudo mv cloudflared /usr/local/bin
sudo chmod +x /usr/local/bin/cloudflared
#cloudflared -v
sudo mkdir /etc/cloudflared
sudo bash -c 'cat  cloudflare.txt > /etc/cloudflared/config.yml'
sudo cloudflared service install
sudo systemctl enable cloudflared
#
#tunnel: xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx
#hostname: demo.snjallingur.is
#url: http://127.0.0.1:8123
#logfile: /var/log/cloudflared.log
#credentials-file: /home/homeassistant/.cloudflared/tunnel.json
#origincert: /home/homeassistant/.cloudflared/tunnel.json

#Python installation 
#with Pyenv

pip install wheel paho-mqtt requests lxml html5lib bs4


#flashing RaspBee2 Zigbee dongle
#Install falshing tool
#https://github.com/dresden-elektronik/gcfflasher

git clone https://github.com/dresden-elektronik/gcfflasher.git
cd gcfflasher
./build_posix.sh
#https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/Update-deCONZ-manually#update-in-raspbian
wget https://deconz.dresden-elektronik.de/deconz-firmware/deCONZ_RaspBeeII_0x26720700.bin.GCF
./GCFFlasher -d /dev/ttyS1 -t 60 -f deCONZ_RaspBeeII_0x26720700.bin.GCF
cd ..

#Add to /etc/crontab
30 4 1 * * root    sh /usr/share/hassio/homeassistant/snjallingur_scripts/homeassistant_upgrade.sh
*/10 * * * * snjallingur bash --login -c "/home/snjallingur/.pyenv/shims/python3 /usr/share/hassio/homeassistant/snjallingur_scripts/vegagerdin.py" >> /home/snjallingur/cronjob.log 2>&1
*/15 * * * * snjallingur bash --login -c "/home/snjallingur/.pyenv/shims/python3 /usr/share/hassio/homeassistant/snjallingur_scripts/vedurspa.py" >> /home/snjallingur/cronjob.log 2>&1
*/30 * * * * snjallingur bash --login -c "/home/snjallingur/.pyenv/shims/python3 /usr/share/hassio/homeassistant/snjallingur_scripts/nordurljosaspa.py" >> /home/snjallingur/cronjob.log 2>&1
