FROM fedora:latest

RUN yum -y groupinstall \
    'Xfce Desktop' \
    ; yum clean all

# http://sigkillit.com/2013/02/26/how-to-remotely-access-linux-from-windows/
ADD Xclients /etc/skel/.Xclients

RUN yum -y install \
    firefox \
    supervisor \
    xrdp \
    git \
    ; yum clean all

RUN useradd foo; \
    echo foo:bar | chpasswd

# Configure supervisord to run session manager and xrdp.
ADD xrdp.ini /etc/supervisord.d/

# Allow all users to connect via RDP.
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini; \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
    
# Install Openshift client
RUN mkdir /tmp/openshift ;\
    cd /tmp/openshift; \
    curl -s -L https://github.com/openshift/origin/releases/download/v1.0.1/openshift-origin-v1.0.1-1b60195-linux-amd64.tar.gz | gunzip | tar xvf - ;\
    cp * /usr/bin; \
    cd /tmp; rm -rf /tmp/openshift
    

EXPOSE 3389

LABEL INSTALL="docker run -d --net=host --name NAME IMAGE"

CMD ["supervisord", "-n"]
