#!/bin/bash

coreos_version="beta"

coreos="
http://storage.core-os.net/coreos/amd64-usr/${coreos_version}/coreos_production_pxe.vmlinuz
http://storage.core-os.net/coreos/amd64-usr/${coreos_version}/coreos_production_pxe_image.cpio.gz
http://storage.core-os.net/coreos/amd64-usr/${coreos_version}/coreos_production_pxe.DIGESTS.asc
"

winpe="
http://isebs.cloudapp.net/WinPE_x86.iso
http://isebs.cloudapp.net/WinPE_x86.iso.md5
"

mkdir -p /tftpboot/coreos/ &> /dev/null
cd /tftpboot/coreos/
for file in $coreos; do
  wget $file || exit 1
done

cd /tftpboot/
for file in $winpe; do
  wget $file || exit 1
done
