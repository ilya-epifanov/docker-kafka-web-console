FROM debian:jessie
MAINTAINER Ilya Epifanov <elijah.epifanov@gmail.com>

RUN apt-get update \
 && apt-get install -y openjdk-7-jre-headless openjdk-7-jdk wget unzip git --no-install-recommends \
 && apt-get clean -y \
 && rm -Rf /var/cache/apt/* /tmp/*

RUN cd /tmp \
 && wget -q http://downloads.typesafe.com/play/2.2.1/play-2.2.1.zip \
 && unzip play-2.2.1.zip \
 && git clone https://github.com/aspyker/kafka-web-console.git \
 && cd /tmp/kafka-web-console \
 && git checkout 62780296c466b6b1bc1756fb2838f62d96fb1999 \
 && /tmp/play-2.2.1/play clean compile stage \
 && mv /tmp/kafka-web-console/target/universal/stage/ /kafka-web-console/ \
 && rm -Rf /tmp/*

EXPOSE 9000

CMD exec /kafka-web-console/bin/kafka-web-console -Duser.dir=/data -DapplyEvolutions.default=true
