FROM ruby:2.5-alpine3.9
RUN apk update --no-cache && apk upgrade --no-cache
RUN apk add --no-cache g++
RUN apk add --no-cache make
RUN gem install jekyll
RUN gem install bundler
COPY ./src/Gemfile /blog/Gemfile
COPY ./src/Gemfile.lock /blog/Gemfile.lock
WORKDIR /blog
RUN bundle install
COPY ./ /blog
WORKDIR /blog/src
VOLUME ["/blog/src"]
ENTRYPOINT ["jekyll"]
