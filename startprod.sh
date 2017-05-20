#!/bin/sh

mix clean
mix deps.clean --all
mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod PORT=4001 elixir --detached -S mix do compile, phoenix.server
echo $!
