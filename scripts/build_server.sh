mix deps.get --only prod
mix compile
# Restart server
kill $(pgrep -f phoenix)
PORT=4000 elixir --detached -S mix phoenix.server
