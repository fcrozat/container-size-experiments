#!/bin/bash

set -x

# build a minimal image
newcontainer=$(buildah from registry.access.redhat.com/ubi8/ubi-micro)
scratchmnt=$(buildah mount $newcontainer)

# install the packages
curl -o /$scratchmnt/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt
yum install --nogpgcheck --installroot $scratchmnt --releasever 8 -y nginx
yum clean all --installroot $scratchmnt
# set some config info
buildah config --label name=nginx-buildah-ubi8-micro $newcontainer

# commit the image
buildah unmount $newcontainer
buildah commit $newcontainer nginx-buildah-ubi8-micro
