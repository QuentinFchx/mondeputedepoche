defmodule An.Feed.DeputeVoteScrutin do
  import Ecto.Query

  alias An.Activity
  alias An.ScrutinDeputeVote
  alias An.Repo

  def get_depute_votes(depute, before \\ DateTime.utc_now, limit) do
    query = from scrutin in Ecto.assoc(depute, :scrutins),
      where: scrutin.published_at < ^before,
      order_by: [desc: scrutin.published_at],
      limit: ^limit

    query
    |> Repo.all
    |> Enum.map(fn(scrutin) -> activity_for_depute_scrutin(depute, scrutin) end)
  end

  def activity_for_depute_scrutin(depute, scrutin) do
    vote =
      ScrutinDeputeVote
      |> Repo.get_by(depute_uid: depute.uid, scrutin_uid: scrutin.uid)

    scrutin_obj =
      Activity.scrutin_to_object(scrutin)
      |> Map.put(:vote, Activity.vote_to_object(vote))

    %Activity{
      actor: Activity.depute_to_actor(depute),
      verb: "vote_scrutin",
      object: scrutin_obj,
      published: scrutin.published_at
    }
  end
end
