# build DemoWebApp image
# cd "C:\zTechTalk-2018-08-02\publish"
docker build -t demowebapp -f demowebapp.Dockerfile .

docker images

docker run -d -p 8000:80 --name demowebapp demowebapp
docker rmi demowebapp
docker rm -f demowebapp

docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" demowebapp
