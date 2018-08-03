# Hello World
# iisreset /STOP
docker version

docker image pull microsoft/windowsservercore
docker pull microsoft/nanoserver
docker images

## Print hostname
docker container run microsoft/windowsservercore hostname

## run powershell
docker run -it microsoft/windowsservercore powershell
whoami
get-windowsfeature

