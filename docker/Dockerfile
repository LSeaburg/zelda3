# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Set the maintainer label
LABEL maintainer="logan.seaburg@gmail.com"

# Update the package list and install basic utilities
RUN apt-get update && \
    apt-get install -y \
    bash \
    curl \
    sudo \
    make \
    gcc \
    git \
    vim \
    libsdl2-dev \
    python3 \
    wget \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# COPY own version of install-devkitpro-pacman into container to install without prompts
# RUN wget -q https://apt.devkitpro.org/install-devkitpro-pacman # && \
COPY docker/install-devkitpro-pacman ./install-devkitpro-pacman
RUN chmod +x ./install-devkitpro-pacman && \
    sudo ./install-devkitpro-pacman

RUN curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz && \
    mkdir -p  /runner/_work/zelda3/zelda3/assets/ && \
    tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz -C /runner 

# Set the working directory
WORKDIR /runner

# Copy the start.sh script into the container
COPY docker/start.sh /runner/start.sh

# Make the script executable
RUN chmod +x /runner/start.sh
RUN chmod -R 777 /var

RUN useradd -m runner

RUN usermod -aG sudo runner

# Allow 'myuser' to run sudo commands without a password
RUN echo 'runner ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN sed -i 's/^Defaults\s\+requiretty/# Defaults requiretty/' /etc/sudoers

USER runner

COPY ../zelda3.sfc /runner/zelda3.sfc

# Set the entry point to the start.sh script
ENTRYPOINT ["/runner/start.sh"]
