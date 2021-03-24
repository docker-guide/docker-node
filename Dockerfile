FROM alpine
LABEL maintainer="starkwang starkland@163.com"
LABEL name="node-run"
LABEL version="latest"
WORKDIR /home/app

RUN apk add --no-cache --update nodejs nodejs-npm yarn curl \
  && rm -rf /var/cache/apk/* \
  && npm i -g pm2 \
  && pm2 -v \
  && node -v && npm -v && yarn -v \
  # 设置时区
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp