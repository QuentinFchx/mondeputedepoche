defmodule An.Feed.DeputeDeposeAmendement do
  import Ecto.Query

  alias An.Activity
  alias An.Repo

  def get_depute_amendements(depute, before \\ DateTime.utc_now(), limit \\ 20) do
    depute
    |> Ecto.assoc(:amendements)
    |> where([q], q.published_at < ^before)
    |> order_by(desc: :published_at)
    |> limit(^limit)
    |> Repo.all
    |> Enum.map(fn(amendement) -> activity_for_depute_amendement(depute, amendement) end)
  end

  def activity_for_depute_amendement(depute, amendement) do
    %Activity{
      actor: Activity.depute_to_actor(depute),
      verb: "depose_amendement",
      object: Activity.amendement_to_object(amendement),
      published: amendement.published_at
    }
  end
end
