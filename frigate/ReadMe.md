## Setup Docker
## Pull docker image:
```
docker pull blakeblackshear/frigate:dev-34c7697-arm64 
```
## Run Docker container:
```
docker run -d \
  --name frigate \
  --restart=unless-stopped \
  -e FRIGATE_RTSP_PASSWORD='frigatecd ' \
  -v /home/homeassistant/.homeassistant/frigate.yaml:/config/config.yml:ro \
  -v /home/homeassistant/Videos/Frigate:/media/frigate \
  -v /etc/localtime:/etc/localtime:ro \
  -p 5000:5000 \
  -p 1935:1935 \
  blakeblackshear/frigate:stable-armv7
```
