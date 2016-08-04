defmodule An.FeedReader do
  def read_feed_of(user) do
    user_id = 1000
    Redix.command!(:redix, ~w(LRANGE users:#{user_id} 0 -1))
  end
end
