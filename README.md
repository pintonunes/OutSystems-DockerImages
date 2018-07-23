# Outsystems Containers
Git hub repository for outsystems docker images.

#### Available Images

**[outsystems-environment](https://github.com/pintonunes/Outsystems-DockerImages/tree/master/outsystems-environment)**

This is a full outsystems environment with SQL Express 2017 as database server.

You can start this container with the following command line:

(Note that you'll need Windows Server 2016 version 1803 or Windows 10)

````
docker run -d -p 1433:1433 -p 80:80 -p 443:443 --memory="4G" --cpu-count 2 --hostname OSCONTAINER pintonunes/outsystems-environment
````
