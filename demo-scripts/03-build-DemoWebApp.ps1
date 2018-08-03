# build DemoWebApp image
# iisreset /STOP

docker build -t demo1 -f demowebapp.Dockerfile .
docker build -t demo2 -f DemoWebWinContainerFullFramework.Dockerfile .

run demo1
docker run -d -p 8000:80 --name demo1 demo1
docker rmi demowebapp
docker rm -f demowebapp

docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" demo1

## List Credential
Import-Module C:\z-publish\CredentialSpec.psm1
Get-CredentialSpec

docker run -d -p 8000:80 --name demo2 demo2
docker run -d -p 8000:80 -h gMSAContG  --security-opt "credentialspec=file://gMSAContG.json" --name demo2 demo2
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" demo2
