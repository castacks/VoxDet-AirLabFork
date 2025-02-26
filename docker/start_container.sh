#!/bin/bash

# This file is obtained from
# https://answers.ros.org/question/300113/docker-how-to-use-rviz-and-gazebo-from-a-container/
# and
# https://medium.com/intro-to-artificial-intelligence/rviz-on-docker-bdf4d0fca5b

XAUTH=/tmp/.docker.xauth

echo "Preparing Xauthority data... "
xauth_list=$(xauth nlist :0 | tail -n 1 | sed -e 's/^..../ffff/')
if [ ! -f $XAUTH ]; then
    if [ ! -z "$xauth_list" ]; then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

echo "Done. "
echo ""
echo "Verifying file contents: "
file $XAUTH
echo "--> It should say \"X11 Xauthority data\"."
echo ""
echo "Permissions:"
ls -FAlh $XAUTH
echo ""
echo "Running docker... "

docker run \
    -it \
    --rm \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$XAUTH:$XAUTH" \
    --volume="/path/to/voxdet_src/:/scripts/" \
    --volume="/path/to/data/BOP/:/data/" \
    --volume="/path/to/working/directory/:/WD/" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --env="NVIDIA_VISIBLE_DEVICES=all" \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --network host \
    --ipc host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --privileged \
    --group-add audio \
    --group-add video \
    --name sony \
    --gpus=all \
    $1 \
    /bin/bash

echo "Out of the container. "
