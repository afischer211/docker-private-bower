FROM node:latest

MAINTAINER Alexander Fischer <Fischer.Alexander@web.de>

# Bower registry, git cache and svn cache ports
EXPOSE 5678 6789 7891

VOLUME /data

WORKDIR /home/private-bower

ADD ./bowerConfig.json /home/private-bower/bowerConfig.json
ADD ./launch.sh /home/private-bower/launch.sh
ADD ./ssh/ /root/.ssh
ADD ./log4js.conf.json /home/private-bower/log4js.conf.json

# Work around company firewalls blocking the git protocol
RUN git config --global url."https://github.com/".insteadOf "git://github.com/" \
 && git config --global user.email "private-bower@example.org" \
 && git config --global user.name "Private Bower" \
 && npm install -g private-bower && npm cache clear \
 && chmod a+x-w /home/private-bower/launch.sh \
 && chmod a-w-x /home/private-bower/bowerConfig.json \
 && chmod a-w-x /home/private-bower/log4js.conf.json

CMD ["./launch.sh"]
