## Docker installation 

RaspberryPi (arm64)
```
docker run -d \
  --name z2mqtt \
  --restart=unless-stopped \
  --device=/dev/ttyACM0 \
  -p 8089:8080 \
  -v /home/homeassistant/.homeassistant/zigbee2mqtt:/app/data \
  -v /run/udev:/run/udev:ro \
  -e TZ=Europe/Reykjavik \
  koenkk/zigbee2mqtt
```

A complete list of docker images available for different platforms can be viewed on [Docker](https://hub.docker.com/r/koenkk/zigbee2mqtt/tags)

## Debugging docker:
```
docker logs --tail 50 --follow --timestamps z2mqtt
```
