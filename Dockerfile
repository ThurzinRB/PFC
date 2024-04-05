FROM px4io/px4-dev-ros-noetic

# Set environment variables
ENV LOCAL_USER_ID "$(id -u)"
ENV DISPLAY ":0"

# Set working directory
WORKDIR /src/PX4-Autopilot

# Mount volumes
VOLUME ["/src/PX4-Autopilot", "/tmp/.X11-unix"]

# Expose UDP port
EXPOSE 14570/udp
    
RUN apt install libgazebo8-dev


# Start bash shell
CMD ["bash"]

# docker run -it --privileged
#     --name=px4-ros mypx4