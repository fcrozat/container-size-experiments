#!/bin/bash

set -x

# build a minimal image
newcontainer=$(buildah from scratch)
scratchmnt=$(buildah mount $newcontainer)

# install the packages
zypper --root $scratchmnt ar 'https://updates.suse.com/SUSE/Products/SLE-BCI/$releasever_major-SP$releasever_minor/$basearch/product/' SLE_BCI
zypper --root $scratchmnt --non-interactive --releasever 15.3 --gpg-auto-import-keys in --no-recommends distribution-release nginx
zypper --root $scratchmnt clean

# set some config info
buildah config --label name=nginx-bci-scratch $newcontainer

# commit the image
buildah unmount $newcontainer
buildah commit $newcontainer nginx-bci-buildah-scratch