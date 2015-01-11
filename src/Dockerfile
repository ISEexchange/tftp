# https://registry.hub.docker.com/_/fedora/
FROM fedora:21

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

ADD decode.sh /
ADD download.sh /
ADD start.sh /usr/local/sbin/
ADD tftpboot/ /tftpboot/

# Show image build date in PXE menu.
RUN sed -i "s/DATE/$(date)/g" /tftpboot/F1.msg

# Work around https://bugzilla.redhat.com/show_bug.cgi?id=1066983
RUN yum remove -y \
    vim-minimal \
    ; yum clean all

# Install dependencies.
RUN yum install -y \
    wget sharutils \
    tftp-server syslinux-tftpboot \
    ; yum clean all

RUN /decode.sh
RUN /download.sh

# Add unprivileged user other than "nobody".
RUN useradd user

VOLUME ["/tftpboot/pxelinux.cfg"]

CMD /usr/local/sbin/start.sh
EXPOSE 69/udp
