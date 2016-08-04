defmodule An.Feed.DeputeDeposeAmendement do
  import Ecto.Query

  alias An.Activity
  alias An.Repo

  def get_depute_amendements(depute, limit) do
    depute
    |> Ecto.assoc(:amendements)
    |> limit(^limit)
    |> Repo.all
    |> Enum.map(fn(amendement) -> activity_for_depute_amendement(depute, amendement) end)
  end

  defp activity_for_depute_amendement(depute, amendement) do
    %Activity{
      actor: Activity.depute_to_actor(depute),
      verb: "depose_amendement",
      object: Activity.amendement_to_object(amendement),
      published: amendement.inserted_at
    }
  end
end
