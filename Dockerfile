FROM elixir:1.4

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

ENV NODE_VERSION 7

RUN mix archive.install --force \ 
    https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

ADD mix.exs /usr/src/app/mix.exs
ADD mix.lock /usr/src/app/mix.lock

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x -o nodesource_setup.sh; \
    /bin/bash nodesource_setup.sh; apt-get install -y nodejs build-essential

ADD package.json /usr/src/app/package.json
ADD brunch-config.js /usr/src/app/brunch-config.js

RUN npm i

ADD . /usr/src/app

EXPOSE 4000

CMD ["mix", "phoenix.server"]