# Windows container - Containerizing legacy Full Framework IIS application

## What you will need

- Windows 10 or Windows server 2016
- Visual studio 2017
- Ask domain admin for a "Group Managed Service Accounts" (Steps 1 to 7)
- Create a product table and populate with data [product.sql](/demo-scripts/product.sql)
- Create Share folder and give read-write permission to the created service account in step 1 to 2. (Hint use **domain\serviceaccountname$** format while adding service account). Create hello.text under shared folder.
- Modify [Web.config](./DemoWebWinContainerFullFramework/DemoWebWinContainerFullFramework/Web.config)
  - testfilepath
  - connectionString

## About DemoWebApp application

- Is a default template ASP.NET, .NET Framework 4.7.1 using MVC and WebApi.

## About DemoWebWinContainerFullFramework application

- ASP.NET, .NET Framework 4.7.1, MVC and WebApi application using Windows authentication
- Database connection using windows authentication
- Read Write to the protected shared folder
- Using [Microsoft.Configuration.ConfigurationBuilders.Environment](https://www.nuget.org/packages/Microsoft.Configuration.ConfigurationBuilders.Environment/) to overide application settings (requires .NET Framework 4.7.1)

### Build and publish "DemoWebApp" and "DemoWebWinContainerFullFramework" applications

### Follow "02-hello-world.ps1" and "03-build-DemoWebApp.ps1"

### Follow swagger URL in the demo2 application and test all APIs

### Reference

[Install Windows container](https://github.com/docker/labs/tree/master/windows/windows-containers)

[Windows containers with an emulated domain identity](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/b1960f4da9731f85ddf672fa3cf956a313a78f5b/windows-server-container-tools/ServiceAccounts)

[Setting up IIS with User Authorization in Windows Server containers - PatrickLang](https://gist.github.com/PatrickLang/27c743782fca17b19bf94490cbb6f960)

[Step-by-Step Guide to Configure Group Managed Service Accounts](http://blog.windowsserversecurity.com/2015/01/27/step-by-step-guide-to-configure-group-managed-service-accounts/ )

[Active Directory Service Accounts for Windows Containers](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/manage-serviceaccounts )

[Create a Container with Active Directory Support](<https://blogs.msdn.microsoft.com/containerstuff/2017/01/30/create-a-container-with-active-directory-support/> )

## 1. The domain needs a master root key

### Chekc master root key

```powershell
Get-KdsRootKey
```

### Create key (**Do not use this for production environments**)

```powershell
Add-KdsRootKey –EffectiveTime ((get-date).addhours(-10))
```

## 2. Create an Active Directory security group to hold the hosts and add hosts

### Create group

```powershell
New-ADGroup -GroupCategory Security -DisplayName "mycontainerhosts" -Name mycontainerhosts -GroupScope Universal
```

### Assign hosts/node-computers

```powershell
Add-ADGroupMember -Identity mycontainerhosts -Members (Get-ADComputer -Identity doc-cli-srv16)
# "doc-cli-srv16" replace with your host machine name.
```

### Verify group members

```powershell
Get-ADGroupMember "mycontainerhosts"
```

## 3 Create Group Managed Service account

```powershell
New-ADServiceAccount -name gMSAContG -DnsHostName devbox.local -ServicePrincipalNames http/gMSAContG.devbox.local -PrincipalsAllowedToRetrieveManagedPassword mycontainerhosts
```

### Restart

> **Restart all node \ Machines**

## 4. Configure the hosts to use the Group Managed Service account

### Install and load the ActiveDirectory PowerShell module

```powershell
Add-WindowsFeature RSAT-AD-PowerShell
Import-Module ActiveDirectory
```

## 5. Install and Validate (on each node)

```powershell
Install-AdServiceAccount gMSAContG
Test-AdServiceAccount gMSAContG
```

## 6. Creating CredentialSpecs

### Load the CredentialSpec module

```powershell
git clone https://github.com/MicrosoftDocs/Virtualization-Documentation.git

Import-Module .\Virtualization-Documentation\windows-server-container-tools\ServiceAccounts\CredentialSpec.psm1
```

or

```powershell
Start-BitsTransfer https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Documentation/b1960f4da9731f85ddf672fa3cf956a313a78f5b/windows-server-container-tools/ServiceAccounts/CredentialSpec.psm1

Import-Module ./CredentialSpec.psm1
```

### Create a credential spec

```powershell
New-CredentialSpec -Name gMSAContG -AccountName gMSAContG
```

### List credential spec

```powershell
Get-CredentialSpec
```

## 7. Run container

```powershell
docker run -d -p 8000:80 -h gMSAContG --security-opt "credentialspec=file://gMSAContG.json" --name NAME NAME
```

### Lookup container IP address

```powershell
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" NAME
```

### Verify

```powershell
docker exec -it [container-id] cmd

c:\> nltest.exe /parentdomain

c:\> klist
```
