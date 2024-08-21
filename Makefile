###########################
# make build
# make run INTERFACE=eth0 FIRMWAREVERSION=1100
# make rm
# make rmi
# make all INTERFACE=eth0 FIRMWAREVERSION=1100
###########################

.PHONY: build run rm rmi all

INTERFACE ?= eth0
FIRMWAREVERSION ?= 1100
IMAGE_TAG = localhost/pppwn-cpp:latest

build:
	podman build -t $(IMAGE_TAG) .
	podman save -o pppwn-cpp.tar $(IMAGE_TAG)
	sudo podman load -i pppwn-cpp.tar

run:
	sudo podman run -d --name pppwn --network host --privileged --env INTERFACE=$(INTERFACE) --env FIRMWAREVERSION=$(FIRMWAREVERSION) --restart on-failure $(IMAGE_TAG)

rm:
	sudo podman stop pppwn
	sudo podman rm pppwn

rmi:
	sudo podman rmi $(IMAGE_TAG)
	podman rmi $(IMAGE_TAG)
	rm pppwn-cpp.tar

all: build run
clean: rm rmi
