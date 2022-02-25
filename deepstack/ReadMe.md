## Docker installation 

RaspberryPi (arm64)
```
docker run -d \
  --name deepstack \
  --restart=unless-stopped \
  -e VISION-FACE=True \
  -v /home/homeassistant/.homeassistant/deepstack:/datastore \
  -p 8088:5000 deepquestai/deepstack:arm64
```

## Debugging docker:
```
docker logs --tail 50 --follow --timestamps deepstack
```
