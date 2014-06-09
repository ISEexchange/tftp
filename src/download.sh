#!/bin/bash
set -e

function download_coreos() {
  version=$1

  coreos_files="
  http://storage.core-os.net/coreos/amd64-usr/${version}/coreos_production_pxe.vmlinuz
  http://storage.core-os.net/coreos/amd64-usr/${version}/coreos_production_pxe_image.cpio.gz
  http://storage.core-os.net/coreos/amd64-usr/${version}/coreos_production_pxe.DIGESTS.asc
  "

  mkdir -p /tftpboot/coreos/$version &> /dev/null
  cd /tftpboot/coreos/$version
  for file in $coreos_files; do
    wget $file
  done
}

coreos_versions="
alpha
beta
"

for version in $coreos_versions; do
  download_coreos $version
done

winpe="
http://isebs.cloudapp.net/WinPE_x86.iso
http://isebs.cloudapp.net/WinPE_x86.iso.md5
"

cd /tftpboot/
for file in $winpe; do
  wget $file
done
