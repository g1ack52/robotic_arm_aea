FROM osrf/ros:humble-desktop-full

RUN apt-get update \
 && apt-get install -y tmux \
 && apt-get install -y vim \
 && rm -rf /var/lib/apt/lists/*

COPY urdf/ /urdf_robotic_arm/

ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

#create a non-root user
RUN groupadd --gid $USER_GID $USERNAME \
 && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
 && mkdir /home/$USERNAME/.config && chown $USER_UID:$USER_GID /home/$USERNAME/.config

#set up sudo
RUN apt-get update \
 && apt-get install -y sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
 && rm -rf /var/lib/apt/lists/*


COPY entrypoint.sh /entrypoint.sh
COPY bashrc /home/${USERNAME}/.bashrc 

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["bash"]


