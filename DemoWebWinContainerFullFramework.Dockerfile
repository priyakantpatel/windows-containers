FROM microsoft/aspnet:4.7.1-windowsservercore-ltsc2016
WORKDIR /inetpub/wwwroot
COPY DemoWebWinContainerFullFramework/DemoWebWinContainerFullFramework/bin/Release/Publish .

ENV appsetting2 "Hello world TWO from environment"

RUN powershell.exe Add-WindowsFeature Web-Windows-Auth

RUN powershell.exe -NoProfile -Command \
  Set-WebConfigurationProperty -filter /system.WebServer/security/authentication/AnonymousAuthentication -name enabled -value false -PSPath IIS:\ ; \
  Set-WebConfigurationProperty -filter /system.webServer/security/authentication/windowsAuthentication -name enabled -value true -PSPath IIS:\ 