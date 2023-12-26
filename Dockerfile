FROM elixir:1.15-alpine

WORKDIR /app

COPY rel ./rel
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .
COPY entrypoint.sh .

RUN mix deps.get

RUN MIX_ENV=prod mix release

ENTRYPOINT sh ./entrypoint.sh
