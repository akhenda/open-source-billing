FROM ruby:2.3.7

# App Utils Installation
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Dependencies for Ruby
RUN apt-get update -yqq \
  && apt-get install -yqq \
    wget \
    gdebi \
    git \
    git-core \
    curl \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    software-properties-common \
    libffi-dev \
    libncurses5-dev \
    automake \
    libtool \
    bison \
    imagemagick \
    libmagickcore-dev \
    libmagickwand-dev \
    libicu-dev \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists
RUN add-apt-repository ppa:ondrej/php

# PDF configurations
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN cp wkhtmltox/bin/* /usr/local/bin
RUN rm -rf wkhtmltox*

WORKDIR /usr/src/osbapp

ENV RAILS_ENV=production

COPY Gemfile .
COPY . .

RUN bundle install
