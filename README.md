## Overview

Docker-based tftp server with PXE boot images.

Start a container with hostname `tftp.example.com` and
specify kickstart server `ks.example.com` in the PXE config:

    docker pull jumanjiman/tftp:latest
    docker run -d -p 69:69/udp -h tftp.example.com -e FQDN=ks.example.com jumanjiman/tftp

Alternatively, create `/etc/systemd/system/tftp.service` with:

```
[Unit]
Description=TFTP Server
After=docker.service
Require=docker.service

[Service]
ExecStartPre=modprobe nf_conntrack_tftp
ExecStartPre=modprobe nf_nat_tftp
ExecStart=/bin/bash -c '/usr/bin/docker start -a tftp || /usr/bin/docker run -d --name tftp -p 69:69/udp -h tftp.example.com -e FQDN=ks.example.com jumanjiman/tftp'
ExecStop=/usr/bin/docker stop tftp
RestartSec=5s
Restart=always

[Install]
WantedBy=multi-user.target
```

Then run:

    systemctl start tftp.service
    systemctl enable tftp.service


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
      host must support tftp connection tracking
      container should serve pxelinux.0
      container should serve pxelinux.cfg/default
      container should serve coreos alpha
      container should serve coreos beta

    users with interactive shells
      should only include "root" and "user"
