heat-hpcloud
=============

Dockerfile for a stand-alone OpenStack Heat server to be used with HP Cloud. 

This project is forked from the install scripts [here](https://github.com/cody-somerville/heat-hpcloud).  

Building & running
------------------

To create the Docker image, type:

```bash
   $ git clone https://github.com/opencore/heat-hpcloud
   $ cd heat-hpcloud
   $ docker build -t ferry/heatserver .
```

This will install all the dependencies and the latest version of the Heat server from GitHub. 
Once the image is finished building, you can start the Heat server by typing:

```bash
   $ docker run -d -p 8004:8004 -p 8000:8000 -v `pwd`/logs:/var/log/heat ferry/heatserver
```

By default, the Heat server will try to use the USWest region. If you'd rather use USEast, replace
the `docker` command with:

```bash
   $ docker run -d -p 8004:8004 -p 8000:8000 -v `pwd`/logs:/var/log/heat ferry/heatserver /usr/local/sbin/start-heat USEast
```

Now in order to use the Heat client against this server, type the following:

```bash
   $ export HEAT_URL=http://${IP}:8004/v1/${OS_TENANT_ID}
   $ export OS_NO_CLIENT_AUTH=1
   $ heat stack-create -f templates/simple_single_instance_only.template teststack
```
You'll want to replace $IP with the IP address of the host. $OS_TENANT_ID should be your OpenStack
tenant ID. This assumes that you've already installed the various OpenStack CLI tools and set up your credentials. 
If you haven't, the installation instructions can be found [here](https://community.hpcloud.com/article/command-line-interface-cli-tool-installation-instructions). 