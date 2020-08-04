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
