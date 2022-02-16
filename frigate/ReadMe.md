## Setup Docker
## Pull docker image:
```
for RPI4
docker pull blakeblackshear/frigate:0.10.0-rc1-aarch64 
```
## Run Docker container:
```
docker run -d \
  --name frigate \
  --restart=unless-stopped \
  --mount type=tmpfs,target=/home/homeassistant/Videos/cache,tmpfs-size=1000000000 \
  -e FRIGATE_RTSP_PASSWORD='frigatecd ' \
  -v /home/homeassistant/.homeassistant/frigate.yaml:/config/config.yml:ro \
  -v /home/homeassistant/Videos/Frigate:/media/frigate \
  -v /etc/localtime:/etc/localtime:ro \
  -p 5050:5000 \
  -p 1935:1935 \
  blakeblackshear/frigate:0.10.0-rc1-aarch64
```
