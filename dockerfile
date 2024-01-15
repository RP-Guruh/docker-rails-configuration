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


versi lainnya

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
