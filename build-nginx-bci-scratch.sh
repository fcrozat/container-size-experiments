#!/bin/bash

set -x

# build a minimal image
newcontainer=$(buildah from scratch)
scratchmnt=$(buildah mount $newcontainer)

# install the packages
zypper --root $scratchmnt ar 'https://updates.suse.com/SUSE/Products/SLE-BCI/$releasever_major-SP$releasever_minor/$basearch/product/' SLE_BCI
export ZYPP_CONF=$PWD/scratch-zypp.conf
zypper --root $scratchmnt al cracklib-dict-full
zypper --root $scratchmnt --non-interactive --releasever 15.3 --gpg-auto-import-keys in --no-recommends nginx ca-certificates-mozilla-prebuilt distribution-release
zypper --root $scratchmnt --non-interactive clean -a

# set some config info
buildah config --label name=nginx-scratch-bci $newcontainer

# commit the image
buildah unmount $newcontainer
buildah commit $newcontainer nginx-buildah-bci-scratch
