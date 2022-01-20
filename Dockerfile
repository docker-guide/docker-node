FROM nikolaik/python-nodejs:python3.6-nodejs12

LABEL maintainer="system@kaikeba.com"

WORKDIR /home/node/app/

ADD vips-8.10.5.tar.gz ./

RUN cd vips-8.10.5 && ./configure && make && make install && cd .. \
  && npm install pm2  -g \
  && rm -rf /var/cache/apk/* \
  && rm -rf vips-8.10.5 \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp node-sass
