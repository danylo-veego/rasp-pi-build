# Use Ubuntu 20.04 LTS as base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
  autoconf \
  bmap-tools \
  build-essential \
  chrpath \
  cmake \
  cpio \
  curl \
  debianutils \
  diffstat \
  doxygen \
  gawk \
  gcc-multilib \
  git \
  git-core \
  iputils-ping \
  lib32z1 \
  libegl1-mesa \
  libsdl1.2-dev \
  libtool \
  libtool-bin \
  m4 \
  openjdk-8-jdk \
  openjdk-8-jre \
  pkg-config \
  pylint3 \
  python3 \
  python3-git \
  python3-jinja2 \
  python3-pexpect \
  python3-pip \
  socat \
  texinfo \
  unzip \
  wget \
  xterm \
  xz-utils

# Additional configuration for locale and user
RUN apt-get update && apt-get install -y locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


# Download and install the Repo tool
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
    && chmod a+x /usr/local/bin/repo


# Arguments for netrc file credentials
ARG netrc_machine=code.rdkcentral.com
ARG netrc_login
ARG netrc_password

# Set environment variables based on build arguments
# These are used at runtime to generate the .netrc file
ENV NETRC_MACHINE=${netrc_machine}
ENV NETRC_LOGIN=${netrc_login}
ENV NETRC_PASSWORD=${netrc_password}

# Create build script
COPY build.sh /usr/local/bin/build.sh
RUN chmod a+x /usr/local/bin/build.sh

# Arguments for user ID and group ID
ARG user_id=1000
ARG group_id=1000

# Create a non-root user for builder builds
RUN groupadd -g ${group_id} builder && \
    useradd -m -u ${user_id} -g builder -s /bin/bash builder

# Switch to builder user
USER builder

RUN mkdir -p /home/builder/workspace

COPY --chown=builder .gitconfig /home/builder/.gitconfig
COPY --chown=builder .netrc /home/builder/.netrc
RUN chmod 600 /home/builder/.netrc
RUN chmod 600 /home/builder/.gitconfig

# Set work directory
WORKDIR /home/builder/

#RUN mkdir -p "$HOME/bin"
#RUN echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
#RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > "$HOME/bin/repo"
#RUN chmod a+x "$HOME/bin/repo"
#RUN which repo

# Entry point
# ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

