#!/bin/bash

set -e

source /opt/ros/humble/setup.bash

echo "provided arguments: $@"

exec $@
