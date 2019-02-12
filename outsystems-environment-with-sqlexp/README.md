# outsystems-controller-with-sqlexp

This is a standaline outsystems environment with SQL Express 2017.

You can start this container with the following command line on Windows 10 with hyper-v isolation:

````
docker run -d --memory="4G" --cpu-count 2 --hostname OSCONTAINER pintonunes/outsystems-environment-with-sqlexp
````
**Docker Parameters:**

**--memory:** Memory used by the container.

**--cpu-count:** Number of logical CPUs used by the container.

**--hostname:** Hostname of the container.