FROM nikolaik/python-nodejs:python3.6-nodejs12-alpine
LABEL maintainer="starkwang starkland@163.com"
LABEL name="node-run"
LABEL version="latest"
WORKDIR /home/app

RUN npm install  pm2  -g \
  && rm -rf /var/cache/apk/* \
  # 设置时区
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp
