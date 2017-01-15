FROM hub.c.163.com/library/ubuntu:16.04

RUN sed -i s@archive.ubuntu.com@mirrors.aliyun.com@g /etc/apt/sources.list

RUN cat /etc/apt/sources.list

ENV NPM_CONFIG_LOGLEVEL warn
ENV NODE_VERSION 6.9.4

RUN apt-get update
RUN apt-get install -y curl xz-utils


# 安装nodejs
COPY ./node/node-v6.9.4-linux-x64.tar.xz /
RUN tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 &&\
    ln -s /usr/local/bin/node /usr/local/bin/nodejs &&\
    node -v && npm -v

# 入口命令
ENTRYPOINT ["/bin/bash"]
