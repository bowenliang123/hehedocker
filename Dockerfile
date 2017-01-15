FROM hub.c.163.com/library/ubuntu:16.04

ENV NPM_CONFIG_LOGLEVEL warn
ENV NODE_VERSION 6.9.4

RUN apt-get update
RUN apt-get install curl

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs
  && ln -s /usr/local/bin/npm /usr/local/bin/npm

# Set the working directory
WORKDIR   /src

RUN node -v &&\
    npm -v


# 入口命令
ENTRYPOINT ["/bin/bash"]
