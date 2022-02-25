##Docker installation 

RaspberryPi (arm64)

docker run -e VISION-FACE=True -v localstorage:/datastore -p 80:5000 deepquestai/deepstack:arm64
