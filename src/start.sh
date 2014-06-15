#!/bin/bash

# http://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
FQDN=${FQDN:-ks.example.com}

cat /tftpboot/default > /tftpboot/pxelinux.cfg/default
sed -i "s/KS\.FQDN/${FQDN}/g" /tftpboot/pxelinux.cfg/default

/usr/sbin/in.tftpd --listen --foreground --verbose --secure --user user /tftpboot
