#!/bin/bash

set -x

# build a minimal image
newcontainer=$(buildah from $1)
scratchmnt=$(buildah mount $newcontainer)

rpm -qa --root $scratchmnt | sort > $(echo $newcontainer| sed -e 's/working.*//g')packagelist.txt

# commit the image
buildah unmount $newcontainer
