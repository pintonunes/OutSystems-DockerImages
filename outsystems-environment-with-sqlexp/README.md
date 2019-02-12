# outsystems-controller

This is a full outsystems environment with SQL Express 2017.

You can start this container with the following command line:

(Note that you'll need Windows Server 2016 version 1803 or Windows 10)

````
docker run -d --memory="4G" --cpu-count 2 --hostname OSCONTAINER pintonunes/outsystems-environment
````
**Docker Parameters:**

**--memory:** Memory used by the container.

**--cpu-count:** Number of logical CPUs used by the container.

**--hostname:** Hostname of the container.