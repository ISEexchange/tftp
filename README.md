## Overview

Docker-based tftp server with PXE boot images.

Start a container with hostname `tftp.example.com` and
specify kickstart server `ks.example.com` in the PXE config:

    docker pull jumanjiman/tftp:latest
    docker run -d -p 69:69/udp -h tftp.example.com -e FQDN=ks.example.com jumanjiman/tftp


Test harness
------------

    contributor friction
      there should not be any

    jumanjiman/tftp
      image
        should be available
      docker
        should expose tftp port and only tftp port

    tftpd
      host must support tftp nat
      container should serve pxelinux.0

    users with interactive shells
      should only include "root" and "user"
