#!/bin/bash

docker run -it \
  --user ros \
  --network=host \
  --ipc=host \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --env=DISPLAY \
  my_image:latest

