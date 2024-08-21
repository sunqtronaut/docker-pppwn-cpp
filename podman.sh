#!/bin/bash

###########################
# ./podman.sh build
# ./podman.sh run eth0 1100
# ./podman.sh rm
# ./podman.sh rmi
# ./podman.sh clean
# ./podman.sh all eth0 1100
###########################

INTERFACE=${2:-eth0}
FIRMWAREVERSION=${3:-1100}
IMAGE_TAG="localhost/pppwn-cpp:latest"

build_image() {
    echo "Building Docker image with tag $IMAGE_TAG..."
    podman build -t $IMAGE_TAG .
    podman save -o pppwn-cpp.tar $IMAGE_TAG
    sudo podman load -i pppwn-cpp.tar
}

run_container() {
    echo "Running container..."
    sudo podman run -d \
        --name pppwn \
        --network host \
        --privileged \
        --env INTERFACE=$INTERFACE \
        --env FIRMWAREVERSION=$FIRMWAREVERSION \
        --restart on-failure \
        $IMAGE_TAG
}

stop_and_remove_container() {
    echo "Stopping and removing container..."
    sudo podman stop pppwn
    sudo podman rm pppwn
}

remove_image() {
    echo "Removing image..."
    podman rmi $IMAGE_TAG
    sudo podman rmi $IMAGE_TAG
    rm pppwn-cpp.tar
}

case "$1" in
    build)
        build_image
        ;;
    run)
        run_container
        ;;
    rm)
        stop_and_remove_container
        ;;
    rmi)
        remove_image
        ;;
    clean)
        stop_and_remove_container
        remove_image
        ;;
    all)
        build_image
        run_container
        ;;
    *)
        echo "Usage: $0 {build|run|rm|rmi|clean|all} [INTERFACE] [FIRMWAREVERSION]"
        exit 1
esac

exit 0
