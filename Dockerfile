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

# AWS command line
RUN pip install --upgrade pip
RUN pip install awscli

WORKDIR /home

# graphtyper 
RUN wget --no-check-certificate https://github.com/DecodeGenetics/graphtyper/releases/download/v2.2.1/graphtyper \
        && chmod a+x graphtyper && mv graphtyper /bin/
# run with: graphtyper genotype_sv <REFFASTA> <VCF> --sam=<BAM> --region=<REGION>

# graphtyper-pipelines
# dependency: vt
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        autoconf \
        libcurl4-openssl-dev \
        g++ \
        libssl-dev \
        && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/atks/vt.git && \
        cd vt && \
        git checkout 2187ff6347086e38f71bd9f8ca622cd7dcfbb40c && \
        make && \
        mv vt /bin/
# dependency: bamShrink
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        unzip \
        && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/DecodeGenetics/bamShrink.git && \
        cd bamShrink && \
        git checkout 7c6c4497575409b1afd8f84625ac3b5e256f53af && \
        unzip seqan.zip && \
        make bamShrink && \
        mv bamShrink /bin/
# pipelines
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/DecodeGenetics/graphtyper-pipelines.git /graphtyper-pipelines
# run with: bash /graphtyper-pipelines/make_graphtyper_sv_pipeline.sh <BAM> [CONFIG]

