## Overview

Docker-based tftp server with PXE boot images.

Start a container with hostname `tftp.example.com` and
specify kickstart server `yum.example.com` in the PXE config:

    docker pull ISEexchange/tftp:latest
    docker run -d -p 69:69/udp -h tftp.example.com -e FQDN=yum.example.com ISEexchange/tftp


Test harness
------------

    contributor friction
      there should not be any

    ISEexchange/tftp
      image
        should be available
      docker
        should expose tftp port and only tftp port

    users with interactive shells
      should only include "root" and "user"
