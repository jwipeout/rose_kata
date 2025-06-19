FROM ruby:3.4.4-bookworm

COPY . /root

WORKDIR /root

RUN bundle install
