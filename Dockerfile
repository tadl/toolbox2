FROM ruby:2.6.3

# Point EOL Debian buster to archive mirrors so apt can work
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list \
 && sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list \
 && sed -i 's|^deb http://.* buster-updates|deb http://archive.debian.org/debian buster-updates main|g' /etc/apt/sources.list

# Update with expired metadata allowed, then install build tools
RUN apt-get -o Acquire::Check-Valid-Until=false update \
 && apt-get install -y --no-install-recommends \
      curl gnupg build-essential python3 make g++ git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# OS deps (add build tools!)
RUN apt-get --allow-releaseinfo-change update \
 && apt-get install -y --no-install-recommends \
    curl gnupg build-essential python3 make g++ git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Node 12 + Yarn
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get -qqyy install nodejs yarn && rm -rf /var/lib/apt/lists/*

# Help node-gyp find Python 3
ENV npm_config_python=/usr/bin/python3

# Install Gems / JS deps
WORKDIR /tmp
COPY Gemfile* /tmp/
RUN bundle config set without 'development test' \
 && bundle install --jobs 5 --retry 5
COPY package.json yarn.lock* /tmp/
RUN yarn install --frozen-lockfile || yarn install

# App
RUN mkdir /app
WORKDIR /app
COPY . /app

ENV RAILS_ENV=production RACK_ENV=production NODE_ENV=production \
    RAILS_SERVE_STATIC_FILES=true

# (optional but recommended) precompile assets if your app uses webpacker in prod
# ENV SECRET_KEY_BASE=dummy
# RUN bundle exec rake assets:precompile

CMD ["bin/run-dev.sh"]
