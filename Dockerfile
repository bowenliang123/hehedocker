FROM hub.c.163.com/library/ubuntu:16.04

RUN sed -i s@archive.ubuntu.com@mirrors.aliyun.com@g /etc/apt/sources.list &&\
    apt-get update &&\
    apt-get install -y curl xz-utils libpng-dev

# 安装nodejs
COPY ./node/node-v6.9.4-linux-x64.tar.xz /
RUN tar -xJf "node-v6.9.4-linux-x64.tar.xz" -C /usr/local --strip-components=1 &&\
    ln -s /usr/local/bin/node /usr/local/bin/nodejs &&\
    node -v && npm -v

RUN npm -g install bower svgo

# 入口命令
ENTRYPOINT ["/bin/bash"]
