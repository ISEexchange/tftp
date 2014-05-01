#!/bin/bash

paths="$(find /tftpboot/ -regex '.*\.base64')"
for path in $paths; do
  dir=$(dirname $path)
  file=$(basename $path)
  pushd $dir &> /dev/null
  uudecode $file
  rm -f $file
  popd &> /dev/null
done
