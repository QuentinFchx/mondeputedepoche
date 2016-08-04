defmodule An.FeedPoster do
  def post(activity) do
    followers = []
    followers
    |> Enum.each(fn(follower) -> post_activity_to(follower, activity) end)
  end

  def post_activity_to(follower, activity) do
    user_id = 1000
    Redix.pipeline(:redix, [~w(LPUSH users:#{user_id} activity), ~w(LTRIM users:#{user_id} 0 100)])
  end

  def set_activity_of(user, activities) do
    user_id = 1000
    activities_list = Enum.join(activities, " ")
    Redix.pipeline(:redix, [~w(DEL users:#{user_id}), ~w(RPUSH users:#{user_id} #{activities_list})])
  end
end
