# build DemoWebApp image
# iisreset /STOP

#Build images
docker build -t demo1 -f demowebapp.Dockerfile .
docker build -t demo2 -f DemoWebWinContainerFullFramework.Dockerfile .

# Verify you have demo1 and demo2 images
docker images

# run demo1 container
docker run -d -p 8000:80 --name demo1 demo1
# Print IP and browse
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" demo1

#  Make sure to stop and clean the running container after each test.
# "docker ps -a" command will get you running containers
# docker rm -f [containerid]

## Verify CredentialSpec
Start-BitsTransfer https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Documentation/b1960f4da9731f85ddf672fa3cf956a313a78f5b/windows-server-container-tools/ServiceAccounts/CredentialSpec.psm1
Import-Module ./CredentialSpec.psm1
Get-CredentialSpec

# run demo2 container (This test give you 401 error and fail)
docker run -d -p 8000:80 --name demo2 demo2
# Print IP and browse
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" demo2
# Don't forget to clean up

# run demo2 container again with security option, you should able to login successfully
docker run -d -p 8000:80 -h gMSAContG  --security-opt "credentialspec=file://gMSAContG.json" --name demo2 demo2
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" demo2
# Don't forget to clean up
 
