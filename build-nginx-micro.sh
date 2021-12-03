#!/bin/bash

set -x

# build a minimal image
newcontainer=$(buildah from registry.suse.com/bci/micro:latest)
scratchmnt=$(buildah mount $newcontainer)

# install the packages
zypper --root $scratchmnt ar 'https://updates.suse.com/SUSE/Products/SLE-BCI/$releasever_major-SP$releasever_minor/$basearch/product/' SLE_BCI
zypper --root $scratchmnt --non-interactive --releasever 15.3 --gpg-auto-import-keys in --no-recommends nginx
rm -rf $scratchmnt/var/cache/rpms

# set some config info
buildah config --label name=nginx-bci-scratch $newcontainer

# commit the image
buildah unmount $newcontainer
buildah commit $newcontainer nginx-bci-buildah-micro
