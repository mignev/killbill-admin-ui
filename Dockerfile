FROM seapy/ruby:2.1.2
MAINTAINER Marian Ignev <m.ignev@gmail.com>

# Install nodejs
RUN apt-get install -qq -y nodejs

# Intall software-properties-common for add-apt-repository
RUN apt-get update
RUN apt-get install -qq -y software-properties-common

# Install Rails App
WORKDIR /app

ADD . /app

RUN bundle install --path /tmp/bundle

RUN cd /app/test/dummy/ && bundle exec rake kaui:install:migrations
RUN cd /app/test/dummy/ && bundle exec rake db:migrate

EXPOSE 3000

ENV RAILS_ENV=development

CMD cd /app/test/dummy/ && bundle exec rails server
