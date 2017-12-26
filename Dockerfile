FROM alpine:latest
LABEL maintainer="gwaewion@gmail.com"
EXPOSE 27017
COPY run.js /root
COPY run.sh /root
VOLUME /data

RUN apk update \
&& apk add mongodb sudo \
&& chown -R mongodb:mongodb /data \
&& chmod +x ~/run.sh \
&& sleep 3 \
&& ~/run.sh \
&& sleep 10 \
&& mongo ~/run.js \
&& killall mongod 

CMD /usr/bin/mongod --auth --port 27017 --dbpath /data
