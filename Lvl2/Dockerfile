#FROM buildpack-deps:jessie-scm
FROM alpine

RUN apk add curl bash

RUN set -x \
    echo @3.10 http://nl.alpinelinux.org/alpine/v3.10/community >> /etc/apk/repositories && \
    echo @3.10 http://nl.alpinelinux.org/alpine/v3.10/main >> /etc/apk/repositories && \
       apk update \
    && apk add --no-cache \
        nodejs \
	nodejs-npm \
        xvfb \
        bzip2 \
        curl \
	py-pip \
        python \
        python-dev \
        py-setuptools \
        build-base \
        libressl-dev \
        libffi-dev \
        unzip \
        chromium@3.10 \
        chromium-chromedriver \
    && pip install ansible boto boto3 awscli

ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/lib/chromium/chrome /usr/bin/chromium-browser \
    && npm install -g @angular/cli --unsafe-perm \
    && npm install -g istanbul \
    && npm install -g jasmine-node \
    && npm install -g jasmine-core@* \
    && npm install -g karma \
    && npm install -g karma-coverage-istanbul-reporter \
    && npm install -g karma-jasmine-html-reporter \
    && npm install -g karma-chrome-launcher \
    && npm install -g karma-jasmine \
    && npm install -g typescript

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

USER root
