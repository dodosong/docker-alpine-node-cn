# node-cn:10 docker
# created by dodosong.20190108
#
# BUILD COMMAND:
# docker build -f node-alpine-cn.Dockerfile  -t dodosong/node-cn:10 .
#
# START COMMAND:
# docker run -d -p 7001:7001 -v $PWD:/data dodosong/node-cn:10   npm i --production --registry=https://registry.npm.taobao.org && npm run start 
# 备注： 让docker用户拥有真正的root权限 --privileged=true

FROM node:10.15.0-alpine

## Change repositories, add dnspod's dns for china, apk update
## build-arg timezone=Asia/Shanghai
RUN  set -ex \
  && echo -e 'nameserver 119.29.29.29' >> /etc/resolv.conf \
  && sed -i 's/http[s]*:\/\/dl-cdn.alpinelinux.org/https:\/\/mirror.tuna.tsinghua.edu.cn/' /etc/apk/repositories \
  && apk update\
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apk del tzdata \
  && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache ## 清除缓存

## Configure it
VOLUME ["/data/code"]
WORKDIR /data/code
EXPOSE 7001
CMD npm start
