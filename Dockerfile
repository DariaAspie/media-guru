FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /media-guru
COPY Gemfile /media-guru/Gemfile
COPY Gemfile.lock /media-guru/Gemfile.lock
WORKDIR /media-guru
RUN bundle
EXPOSE 3000
CMD bin/rails db:create && bin/rails db:migrate && bin/rails s -b 0.0.0.0
