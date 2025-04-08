FROM osrf/ros:humble-desktop-full

# Install basic utilities
RUN apt-get update \
 && apt-get install -y tmux vim sudo \
 && rm -rf /var/lib/apt/lists/*

# Define user variables
ARG USERNAME=aea
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create non-root user and home
RUN groupadd --gid $USER_GID $USERNAME \
 && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
 && mkdir -p /home/$USERNAME/.config \
 && chown -R $USERNAME:$USERNAME /home/$USERNAME

# Create ROS2 workspace mount point (will be mounted from host)
RUN mkdir -p /home/$USERNAME/ros2_ws/src \
 && chown -R $USERNAME:$USERNAME /home/$USERNAME/ros2_ws

# Setup sudo for user
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME

# Copy configuration files
COPY entrypoint.sh /entrypoint.sh
COPY bashrc /home/${USERNAME}/.bashrc
RUN chown $USERNAME:$USERNAME /home/${USERNAME}/.bashrc

# Switch to the user
USER $USERNAME
WORKDIR /home/$USERNAME

# Entrypoint and default command
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["bash"]

