#!/bin/bash

docker run -it \
  --user aea \
  --network=host \
  --ipc=host \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v "$(pwd)/ros2_ws:/home/aea/ros2_ws" \
  --env=DISPLAY \
  -w /home/aea \
  my_image:latest


