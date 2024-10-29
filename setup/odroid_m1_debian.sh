#fix problems with getting IP address and resolve DNS names
sudo nano /etc/network/interfaces
#to get a list of network interfaces available type
#ip link show
#ensure the following lines exist
#auto eth0
#allow-hotplug eth0
#iface eth0 inet dhcp
sudo nano /etc/resolv.conf
#change/add nameservers
#nameserver 1.1.1.1
#nameserver 1.1.1.4
sudo service networking restart
sudp apt-get install systemd-resolved
sudo nano /etc/systemd/resolved.conf
#change/add nameservers
#DNS=1.1.1.1
#FallbackDNS=1.0.0.1
#
#Modify the Kernel loader file
sudo nano /etc/default/flash-kernel
#add apparmor=1 security=apparmor
#Docker cGroupV1
#systemd.unified_cgroup_hierarchy=0
#LINUX_KERNEL_CMDLINE="systemd.unified_cgroup_hierarchy=0 quiet splash security=apparmor apparmor=1"
#update boot file
sudo update-bootscript
#add apparmor to GRUB
sudo nano /etc/default/grub
#add systemd.unified_cgroup_hierarchy=0 quiet splash security=apparmor apparmor=1
sudo update-grub


#sudo useradd -m -s $(which bash) -G sudo snjallingur
#passwd snjallingur
sudo apt-get update
sudo apt-get upgrade


sudo groupadd i2cc
sudo gpasswd -a snjallingur dialout
#add user snjallingur to sudoers
sudo usermod -aG sudo snjallingur

#INstall packages
sudo apt-get -y install  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git bluez
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release pkg-config build-essential libgpiod-dev
sudo apt-get -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git
sudo apt-get -y install -y python3 python3-dev python3-pip odroid-wiringpi libwiringpi-dev apparmor-utils uidmap
sudo apt-get -y install apparmor cifs-utils dbus jq libglib2.0-bin lsb-release network-manager nfs-common systemd-journal-remote udisks2 wget
#systemd-resolved 
sudo nano /etc/NetworkManager/NetworkManager.conf
#change to 
#dns=none 
sudo apt --fix-broken install
sudo reboot
#Docker installation
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker snjallingur

#Installing Hass OS agent
wget https://github.com/home-assistant/os-agent/releases/download/1.6.0/os-agent_1.6.0_linux_aarch64.deb
sudo dpkg -i os-agent_1.6.0_linux_aarch64.deb
#check output of
gdbus introspect --system --dest io.hass.os --object-path /io/hass/os

#Installing pyenv guidelines
#https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
exec "$SHELL"

#Installing Supervisor guidelines
#https://peyanski.com/how-to-install-home-assistant-supervised-official-way/
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
sudo dpkg -i homeassistant-supervised.deb


#Installing Zerotier
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
#join Zerotier network
#sud xxxxxxxxx
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


#flashing RaspBee2 Zigbee dongle
#Install falshing tool
#https://github.com/dresden-elektronik/gcfflasher

git clone https://github.com/dresden-elektronik/gcfflasher.git
cd gcfflasher
./build_posix.sh
#https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/Update-deCONZ-manually#update-in-raspbian
wget https://deconz.dresden-elektronik.de/deconz-firmware/deCONZ_RaspBeeII_0x26780700.bin.GCF
sudo ./GCFFlasher -d /dev/ttyFIQ0 -t 60 -f deCONZ_RaspBeeII_0x26780700.bin.GCF
cd ..

#Add to /etc/crontab
30 4 1 * * root    sh /usr/share/hassio/homeassistant/snjallingur_scripts/homeassistant_upgrade.sh
*/10 * * * * snjallingur bash --login -c "/home/snjallingur/.pyenv/shims/python3 /usr/share/hassio/homeassistant/snjallingur_scripts/vegagerdin.py" >> /home/snjallingur/cronjob.log 2>&1
*/15 * * * * snjallingur bash --login -c "/home/snjallingur/.pyenv/shims/python3 /usr/share/hassio/homeassistant/snjallingur_scripts/vedurspa.py" >> /home/snjallingur/cronjob.log 2>&1
*/30 * * * * snjallingur bash --login -c "/home/snjallingur/.pyenv/shims/python3 /usr/share/hassio/homeassistant/snjallingur_scripts/nordurljosaspa.py" >> /home/snjallingur/cronjob.log 2>&1

#Resizing partion
#follow instructions from here:
#https://wiki.odroid.com/odroid-xu4/software/omv_nas/eng/how_to_expand_rootfs_size

#get WiFi dongle to work
install wireless-tools
sudo nmcli radio wifi on
nmcli device wifi connect <ssid> password <password>
sudo apt update
sudo apt install build-essential git dkms
git clone https://github.com/brektrou/rtl8821CU.git
cd rtl8821CU
chmod +x dkms-install.sh
sudo ./dkms-install.sh


#install unattended upgrades
sudo apt-get install unattended-upgrades apt-listchanges
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
