FROM ubuntu:18.04

MAINTAINER jmonlong@ucsc.edu

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        wget \
        curl \
        git \
        bcftools \
        tabix \
        python \
        python-pip \
        python-setuptools \
        locales \
        make \
        gcc \
        python-dev \
        libbz2-dev liblzma-dev \
        zlib1g zlib1g-dev \
        time \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8

RUN pip install --upgrade pip

RUN pip install awscli

RUN wget --no-check-certificate https://github.com/DecodeGenetics/graphtyper/releases/download/v2.0/graphtyper \
        && chmod a+x graphtyper && mv graphtyper /bin/
