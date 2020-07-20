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
FROM alpine AS builder
WORKDIR /home/app
RUN apk add --no-cache --update nodejs nodejs-npm
COPY package.json package-lock.json ./
RUN npm install --production

FROM  alpine
WORKDIR /home/app
RUN apk add --no-cache --update nodejs nodejs-npm
RUN npm i -g pm2 && node -v && npm -v
COPY --from=builder /home/app/node_modules ./node_modules
COPY . .
# CMD [ "npm", "start" ]
CMD [ "pm2-runtime", "start", "app.js" ]
```
