FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  openjdk-11-jre \
  unzip \
  xvfb \
  socat \
  x11vnc \
  xdotool \
  x11-utils \
  wmctrl \
  expect \
  libxrender1 \
  libxtst6 \
  libxi6 \
  libgtk2.0-0 \
  libnss3 \
  && which xdotool \
  && apt-get clean

ENV IB_GATEWAY_VERSION=1039
ENV IB_INSTALLER=ibgateway-1039-standalone-linux-x64.sh
ENV IB_INSTALL_DIR=/root/Jts

# Copy local installer into image
COPY ${IB_INSTALLER} /tmp/${IB_INSTALLER}

# Install IB Gateway
RUN chmod +x /tmp/${IB_INSTALLER} && \
    /tmp/${IB_INSTALLER} -q -dir ${IB_INSTALL_DIR} && \
    rm /tmp/${IB_INSTALLER}

# Copy entry and login scripts
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY login.sh /usr/local/bin/login.sh
RUN chmod +x /usr/local/bin/*.sh

# Set working directory to the versioned install path
WORKDIR ${IB_INSTALL_DIR}

EXPOSE 4002

ENTRYPOINT ["entrypoint.sh"]
