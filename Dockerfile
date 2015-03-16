FROM ubuntu:14.04

MAINTAINER Tuomas Suutari <tuomas.suutari@andersinno.fi>

RUN \
 apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
 rm -rf /var/lib/apt/lists/*

RUN \
 apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y puppet curl wget

RUN \
 apt-key adv --keyserver keys.gnupg.net --recv-keys D88E42B4

ADD es-demo /es-demo

RUN \
 cd /es-demo/nyc_traffic_accidents/puppet && \
 puppet apply --modulepath=modules manifests/default.pp

RUN \
 /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
