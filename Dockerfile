FROM alpine
LABEL maintainer="starkwang starkland@163.com"
LABEL name="node-run"
LABEL version="latest"
WORKDIR /home/app

RUN apk add --no-cache --update nodejs nodejs-npm yarn curl \
  && yarn global add pm2 \
  && node -v && npm -v && yarn -v \
  && rm -rf /var/cache/apk/* \
  # 设置时区
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp