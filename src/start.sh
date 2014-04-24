#!/bin/bash

FQDN=${FQDN:yum.example.com}
sed -i "s/FQDN/${FQDN}/g" /tftpboot/pxelinux.cfg/default

/usr/sbin/in.tftpd --listen --foreground --verbose --secure --user user /tftpboot
