FROM nikolaik/python-nodejs:python3.6-nodejs12-alpine
LABEL maintainer="starkwang starkland@163.com"
LABEL name="node-base"
LABEL version="latest"
WORKDIR /home/app

RUN wget https://github.com/libvips/libvips/releases/download/v8.10.5/vips-8.10.5.tar.gz && tar -zxvf vips-8.10.5.tar.gz && rm -rf vips-8.10.5.tar.gz && cd vips-8.10.5/ && ./configure && make && make install \
  && npm install  pm2  -g \
  && rm -rf /var/cache/apk/* \
  # 设置时区
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp
