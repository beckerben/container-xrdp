# container-xrdp

Docker container for [xrdp](http://xrdp.org/) (both [Xorg](https://github.com/neutrinolabs/xorgxrdp) and [Xvnc](https://tigervnc.org/)) currently based on [Ubuntu](https://ubuntu.com/). Full desktop environment [Xfce](https://www.xfce.org/) is supported. No privilege or sys_cap is required on the host system. These containers are lightweight and ideal for rapid development and testing purposes. Notice that the state of the container is not persisted between runs. In order to persist the state of the container, see [this guide](https://stackoverflow.com/questions/44480740/how-to-save-a-docker-container-state).

Originally forked from [danchitnis](https://github.com/danchitnis/container-xrdp/) and heavily modified.

## How to use

First build the image using instructions below.

You have to give username, password, and sudo ability as input arguments to the docker run command. Hence, each user has three parameters. The process will exit if the input arguments are incorrect. Please run as interactive mode at first instance.

Example when username is _foo_, password is _bar_ and sudo ability is _no_:

```bash
docker run -d --name xrdp -p 33890:3389 xrdp foo bar no
```

Once running, open Remote Desktop Connection. Enter "localhost:33890" as the address.

In this example username is _foo_ and the password is _bar_.

Notice that to give sudo ability, the third input parameter for each user should be explicitly _yes_, otherwise any other input will be ignored.

## Adding more users

You can add more users as a list of arguments and 3 inputs per user as described above

Example:
| User | Pass | Sudo |
|---|:---:|---:|
| foo | bar | yes |
| baz | cox | no |

```bash
docker run -it -0d --name xrdp -p 33890:3389 xrdp foo bar yes baz qux no
```

## Build

To build the image, run the commands below.  Additional software can be placed in the /opt directory to be installed in the Dockerfile.

```bash
docker build -f ./Dockerfile -t xrdp .
```

then run

```bash
docker run -it -d --name xrdp -p 33890:3389 xrdp foo bar no
```
