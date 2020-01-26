FROM ruby:2.6.5
RUN apt-get update && apt-get install -y postgresql-client nodejs build-essential
WORKDIR /mock-league
COPY Gemfile* ./
RUN bundle install
COPY . .