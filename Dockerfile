FROM hub.c.163.com/library/node:6.9.4-alpine

RUN npm config set loglevel=warn

RUN npm install bower@1.7.9

# 安装运行或构建的依赖包
RUN \
  apk update && apk add \

      # runtime dependencies

      # pngquant
      libpng \

      curl \


  # build dependencies
  && apk add --virtual build-dependencies \
      build-base \

      # pngquant
      bash libpng-dev \

      # mozjpeg
      pkgconfig autoconf automake libtool nasm

# mozjpeg
RUN apk --update add \
	autoconf \
	automake \
	build-base \
	git \
	libtool \
	nasm \
 && rm -rf /var/cache/apk/*

COPY ./mozjpeg-3.1 /mozjpeg
WORKDIR /mozjpeg
RUN autoreconf -fiv \
 && ./configure --with-jpeg8 \
 && make && make install


## jpeg-archive
COPY ./jpeg-archive-2.1.1 /jpeg-archive
#RUN apk add --update jpeg-dev
RUN cd /jpeg-archive/ && make && make install

#################################################################
#  NPM相关


#RUN mkdir /tmp_code
WORKDIR /tmp_code
RUN npm install jpeg-recompress-bin
RUN  \

    # image-webpack-loader
    #(https://github.com/tcoopman/image-webpack-loader)
     npm install image-webpack-loader@2.0.0


# 安装rpg
#RUN npm install -g git+ssh://git@git.ucweb.local:pf/rpg.git

#RUN npm install -g tnpm --registry=http://registry.npm.alibaba-inc.com
#
#################################################################################
## 应用逻辑相关
#
## 加载应用逻辑
#ENV APP_HOME /code
#ENV TEMP_HOME /tmp_code
#
#
#
## 安装npm依赖库，并缓存
#ADD ./package.json ${TEMP_HOME}/package.json
#RUN cd ${TEMP_HOME} && tnpm install
#RUN mkdir -p ${APP_HOME} && cp -a ${TEMP_HOME}/node_modules ${APP_HOME}
#
#
## 复制本地代码
#COPY ./ ${APP_HOME}
#
#
## 暴露端口
#EXPOSE 5000
#
## 入口命令
#ENTRYPOINT ["/bin/bash"]
