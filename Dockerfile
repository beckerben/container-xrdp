FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update 
RUN apt-get -y upgrade

RUN apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin 

RUN apt-get install -y \
    sudo \
    wget \
    xorgxrdp \
    xrdp \
    nano \
    vim \
    nmap \    
    iputils-ping \
    net-tools \ 
    iproute2 \
    wireshark \
    traceroute \
    netcat \
    iftop \
    mtr \
    dnsutils \
    curl \
    python3-pip \
    tcpdump && \
    apt remove -y light-locker xscreensaver && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists

WORKDIR /app
COPY ./build/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./build/ubuntu-run.sh /usr/bin/
RUN mv /usr/bin/ubuntu-run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

RUN mkdir /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession

RUN mkdir -p /opt/software
COPY ./opt/ /opt/software

# Docker config
EXPOSE 3389
ENTRYPOINT ["/usr/bin/run.sh"]

