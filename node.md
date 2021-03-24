```dockerfile
FROM registry.cn-beijing.aliyuncs.com/rdmix/node-build:v1 AS builder

COPY  package.json  ./
RUN yarn --production  --registry http://vd.kaikeba.com --network-timeout 1000000


FROM  registry.cn-beijing.aliyuncs.com/rdmix/node-run:v2
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories    && apk add curl 
WORKDIR /home/app/
ENV HOME=/home/app/ \
    APP_NAME=fig \
    ENABLE_NODE_LOG=YES \
    NODE_LOG_DIR=/tmp

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

COPY . /home/app/
COPY --from=builder /home/app/node_modules  ./node_modules
#RUN chmod +x /usr/src/app/start_agenthub.sh
RUN date +%s  > /bdate.log  && echo `cat /bdate.log`
RUN npm run build:test
#ENTRYPOINT [ "/usr/src/app/start_agenthub.sh" ]
ENTRYPOINT [ "/home/app/run.sh" ]

# 配置服务器端口##
EXPOSE 80
EXPOSE 6020
#CMD  ["pm2-runtime", "start", "ecosystem.config.js" ]
CMD  ["./release/pm2start.sh"]
```


```
FROM rdmix/ubuntu-base:v0.0.1
LABEL maintainer="starkwang starkland@163.com"
LABEL name="node-env"
LABEL version="latest"

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -y nodejs

RUN npm install -g yarn
RUN yarn global add pm2

# Set china mirror
# RUN echo "alias yarn='yarn --registry=https://registry.npm.taobao.org'" >> /etc/bash.bashrc

# Print node versions
RUN node -v
RUN npm -v

RUN yarn config list

# Set WORKDIR to nvm directory
WORKDIR /home

ENTRYPOINT ["/bin/bash"]

```



```
FROM alpine
LABEL maintainer="starkwang starkland@163.com"
LABEL name="node-run"
LABEL version="latest"
WORKDIR /home/app

RUN apk add --no-cache --update nodejs nodejs-npm yarn curl \
  && yarn global add pm2 \
  && pm2 -V \
  && node -v && npm -v && yarn -v \
  && rm -rf /var/cache/apk/* \
  # 设置时区
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

RUN yarn add sharp
```