## base
* size: 62.4mb
```
node:v12.17.0
npm:6.14.4
yarn:1.22.4
```

## build
* size: 62.4mb
```
node:v12.17.0
npm:6.14.4
yarn:1.22.4
```

## run
* pm2:4.4.0 
* size:95.9mb


```js
FROM rdmix/node-build:v0.0.3 AS builder
COPY package.json package-lock.json ./
RUN npm install --production

FROM rdmix/node-run:v0.0.4
WORKDIR /home/app
COPY --from=builder /home/app/node_modules ./node_modules
COPY . .
CMD [ "pm2-runtime", "start", "app.js" ]
```
