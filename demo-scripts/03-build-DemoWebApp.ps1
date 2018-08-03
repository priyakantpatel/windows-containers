# build DemoWebApp image
# cd "C:\zTechTalk-2018-08-02\publish"
docker build -t web1 -f demowebapp.Dockerfile .
docker build -t web1 -f DemoWebWinContainerFullFramework.Dockerfile .

docker images

docker run -d -p 8000:80 --name web1 web1
docker rmi demowebapp
docker rm -f demowebapp

docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" web1
