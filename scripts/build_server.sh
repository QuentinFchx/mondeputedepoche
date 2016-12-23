mix deps.get --only prod
mix compile
# Restart server
pgrep -f phoenix | xargs kill
PORT=4000 elixir --detached -S mix phoenix.server
