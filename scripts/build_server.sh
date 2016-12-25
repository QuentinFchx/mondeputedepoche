mix deps.get --only prod
mix compile
mix ecto.migrate
# Restart server
pgrep -f phoenix | xargs kill
PORT=4000 elixir --detached -S mix phoenix.server
