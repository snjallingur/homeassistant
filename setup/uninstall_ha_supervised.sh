#stop services
sudo systemctl stop hassio-supervisor.service
sudo systemctl stop hassio-apparmor.service
#disable services
sudo systemctl disable hassio-supervisor.service
sudo systemctl disable hassio-apparmor.service
#remove services
sudo rm -rf /etc/systemd/system/hassio-supervisor.service
sudo rm -rf /etc/systemd/system/hassio-apparmor.service
#remove hassio fodlers
sudo rm -rf /usr/sbin/hassio-supervisor
sudo rm -rf /usr/sbin/hassio-apparmor
#stop and remove all docker containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#Remove Supervisor package
#dpkg --remove homeassistant-supervised
sudo dpkg --purge --force-all homeassistant-supervised
#empty directories
sudo rm /usr/share/hassio/apparmor -r
sudo rm /etc/docker -r
#install os-agent
sudo dpkg --purge --force-all os-agent
#install supervisor
#sudo dpkg -i os-agent_1.2.2_linux_aarch64.deb
#sudo dpkg -i homeassistant-supervised.deb
#check installation with
#gdbus introspect --system --dest io.hass.os --object-path /io/hass/os
