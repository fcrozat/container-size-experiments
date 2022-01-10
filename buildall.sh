#!/bin/sh

buildah unshare ./build-nginx-bci-micro.sh
#buildah unshare ./build-nginx-bci-scratch.sh
buildah unshare ./build-nginx-ubi8-micro.sh
for i in ./build-nginx*.sh ; do
	buildah unshare $i
done

for name in bci-base bci-micro bci-minimal bci-scratch ubi8 ubi8-minimal ; do
   podman build -f "Dockerfile.$name" -t "nginx-docker-$name"
done

podman image ls -a | grep nginx
