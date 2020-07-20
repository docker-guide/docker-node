## base

* size: 62.4mb
```
node:v12.17.0
npm:6.14.4
yarn:1.22.4
```

## build
国内地址：registry.cn-beijing.aliyuncs.com/rdmix/node-build:v1
* size: 62.4mb
```
node:v12.17.0
npm:6.14.4
yarn:1.22.4
```

## run
国内镜像：registry.cn-beijing.aliyuncs.com/rdmix/node-run:v1
* pm2:4.4.0 
* size:95.9mb


```js
FROM registry.cn-beijing.aliyuncs.com/rdmix/node-build:v1 AS builder
COPY package.json package-lock.json ./
RUN npm install --production

FROM registry.cn-beijing.aliyuncs.com/rdmix/node-run:v1
WORKDIR /home/app
COPY --from=builder /home/app/node_modules ./node_modules
COPY . .
CMD [ "pm2-runtime", "start", "app.js" ]
```
