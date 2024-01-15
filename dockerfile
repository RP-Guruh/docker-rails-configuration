FROM ruby:alpine3.19

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apk --update --upgrade add \
    build-base \
    mysql-dev \
    nodejs \
    yarn \
    tzdata \
    && gem install bundler \
    && bundle install --jobs 20 --retry 5 \
    && rm -rf /var/cache/apk/*

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
