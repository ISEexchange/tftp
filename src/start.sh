#!/bin/bash

FQDN=${FQDN:ks.example.com}
cat /tftpboot/default > /tftpboot/pxelinux.cfg/default
sed -i "s/KS\.FQDN/${FQDN}/g" /tftpboot/pxelinux.cfg/default

/usr/sbin/in.tftpd --listen --foreground --verbose --secure --user user /tftpboot
