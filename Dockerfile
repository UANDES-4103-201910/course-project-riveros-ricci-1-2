FROM ruby:2.5.1-slim
ARG precompileassets

RUN apt-get update -qq
RUN apt-get install --fix-missing --no-install-recommends -qq -y \
            build-essential \
            wget gnupg \
            git-all \
            curl \
            ssh \
            libsqlite3-dev

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get install -y nodejs
RUN apt-get update && apt-get install -y yarn

RUN gem install bundler
#Install gems
RUN mkdir /gems
WORKDIR /gems
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

RUN ["chmod", "+x", "./potential_asset_precompile.sh"]
RUN ./potential_asset_precompile.sh $precompileassets

#RUN ["chmod", "+x", "./docker-entrypoint.sh"]
#ENTRYPOINT ["./docker-entrypoint.sh"]

EXPOSE 3000

# Default command is starting the rails server
CMD ["bin/rails", "s", "-b", "0.0.0.0"]