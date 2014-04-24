# https://index.docker.io/u/mattdm/fedora/
FROM mattdm/fedora:f20

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

# Work around https://bugzilla.redhat.com/show_bug.cgi?id=1066983
RUN yum remove -y \
    vim-minimal \
    ; yum clean all

# Install dependencies.
RUN yum install -y \
    wget \
    tftp-server syslinux-tftpboot \
    ; yum clean all

ADD tftpboot/ /tftpboot/
ADD start.sh /usr/local/sbin/

ADD download.sh /
RUN /download.sh

RUN chown -R root:root /tftpboot/

# Add unprivileged user other than "nobody".
RUN useradd user

CMD /usr/local/sbin/start.sh
EXPOSE 69/udp
