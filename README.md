Container size experiments

Trying to build a nginx container using various base image

To reproduce, run ./buildall.sh

Run on Jan 10 2022

Image | size
----- | ----
nginx-docker-ubi8         | 310 MB
nginx-docker-ubi8-minimal | 220 MB
nginx-docker-bci-base     | 188 MB
nginx-docker-bci-minimal  | 162 MB
nginx-buildah-ubi8-micro  | 152 MB
nginx-buildah-bci-micro   | 105 MB
nginx-docker-bci-micro    | 105 MB
nginx-bci-docker-scratch  | 99.4 MB



