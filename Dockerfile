FROM nikolaik/python-nodejs:python3.6-nodejs14

LABEL maintainer="system@kaikeba.com"

WORKDIR /home/node/app/

ADD vips-8.12.2.tar.gz ./

RUN cd vips-8.12.2 && ./configure && make && make install && cd .. \
  && npm install pm2  -g \
  && rm -rf /var/cache/apk/* \
  && rm -rf vips-8.12.2 \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp node-sass
