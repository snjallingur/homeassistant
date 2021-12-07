#Installing pyenv guidelines
#https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/

#Installing Supervisor guidelines
#https://peyanski.com/how-to-install-home-assistant-supervised-official-way/

#Installing Hass OS agent
wget https://github.com/home-assistant/os-agent/releases/download/1.2.2/os-agent_1.2.2_linux_aarch64.deb
sudo dpkg -i os-agent_1.2.2_linux_aarch64.deb



#Installing Zerotier
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
#join Zerotier network
#zerotier-cli join xxxxxxxxx

#CLoudflared
#cloudflared tunnel route dns xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx demo.snjallingur.is
#sudo nano /etc/cloudflared/config.yml
#
#tunnel: xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx
#hostname: demo.snjallingur.is
#url: http://127.0.0.1:8123
#logfile: /var/log/cloudflared.log
#credentials-file: /home/homeassistant/.cloudflared/tunnel.json
#origincert: /home/homeassistant/.cloudflared/tunnel.json


#Add to /etc/crontab
#30 4 1 * * root    sh /usr/share/hassio/homeassistant/snjallingur_scripts/homeassistant_upgrade.sh
#*/10 * * * * homeassistant bash --login -c "/home/homeassistant/.pyenv/shims/python3.8 /usr/share/hassio/homeassistant/snjallingur_scripts/vegagerdin.py" >> /home/homeassistant/cronjob.log 2>&1
#*/15 * * * * homeassistant bash --login -c "/home/homeassistant/.pyenv/shims/python3.8 /usr/share/hassio/homeassistant/snjallingur_scripts/vedurspa.py" >> /home/homeassistant/cronjob.log 2>&1
#*/30 * * * * homeassistant bash --login -c "/home/homeassistant/.pyenv/shims/python3.8 /usr/share/hassio/homeassistant/snjallingur_scripts/nordurljosaspa.py" >> /home/homeassistant/cronjob.log 2>&1
