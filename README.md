# PFC

Personal notes about my final course project, here I'll document everything i find usefull for writting the document



## How to install the docker conatainer

Hello my friend, if you're here, you're willing to start to fly. In this case I'll guide you through the path to download and install the gazebo simulation.
First o f all, we need to install docker, if you don't know waht is this you can [click here](https://docs.docker.com/get-docker/) and read someone who knows better than me how to explain it. Run this 2 commands in your /home/user dir

```bash
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

after you're done, you need to invoke docker as root user

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```
Now you need to create the shared directory that your docker container will access

```bash
mkdir src
cd src
```

In this folder you will clone the PX4 repo with the tag --recursive

```bash
git clone https://github.com/PX4/PX4-Autopilot.git --recursive
```

run this command, I don't know why

```
xhost +
```

Reboot your machine!


## Running

To run the simulation you need to start the docker container using this command

```sh
docker run -it --privileged \
    --env=LOCAL_USER_ID="$(id -u)" \
    -v ~/src/PX4-Autopilot:/src/PX4-Autopilot/:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=:0 \
    -p 14570:14570/udp \
    --name=px4-ros px4io/px4-dev-ros-noetic bash
```

It is possible that this returns an error due to the container already started:

```console
docker: Error response from daemon: Conflict. The container name "/px4-ros" is already in use by container "0cdd16963f394ea430349ae7c70ee06c3df1ff5b6c1ce2c0d599f1d3b440f387". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.
```
In this case you have to take the container id and simply kill it, in this case the code starts with 0cd so use this command:

```sh
docker container rm 0cd
```
After this you can just start the container again with the "docker run..." command

If everything goes well you'll see your terminal looking like this:

```bash
Starting with UID : 1000
user@0cdd16963f39:/$
```
>**_NOTE_**:  To leave the docker container type ```exit``` 

You're good to go!
The next step to fly to infinity and beyond is to start the gazebo simulation.

```sh
cd src/PX4-Autopilot
```

```sh
make px4_sitl_default gazebo-classic
```

If everything is ok you should see a gazebo loading screen and after this ...

And there was light -- 

![gazebo image](/img/Screenshot%20from%202024-02-05%2010-45-49.png)

### Usefull links

- [PX4 Docker Containers | PX4 User Guide (main)](https://docs.px4.io/main/en/test_and_ci/docker.html)
- [Building PX4 Software | PX4 User Guide (main)](https://docs.px4.io/main/en/dev_setup/building_px4.html)

## Using a custom world

The default world is boring and colorless. Our friend [Talles](https://github.com/TallesCarvalh0) made a world that we're going to use. Donwload the [file](https://github.com/TallesCarvalh0/DRONES/tree/main/worlds) and insert in this path:

/home/<username>/src/PX4-Autopilot/Tools/simulation/gazebo-classic/sitl_gazebo-classic/worlds




