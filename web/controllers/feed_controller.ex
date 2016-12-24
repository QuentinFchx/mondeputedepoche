defmodule An.FeedController do
  use An.Web, :controller

  alias An.Repo

  def feed(conn, params) do
    citoyen = Map.get(conn.assigns, :citoyen) |> Repo.preload(:followed)

    before = case Map.get(params, "before") do
      nil -> DateTime.utc_now()
      date -> date |> Timex.parse!("{YYYY}-{0M}-{0D}") |> Timex.to_datetime
    end

    activities = An.Feed.generate_feed_for(citoyen.followed, before)

    json(conn, %{data: activities})
  end

  def depute_feed(conn, %{"depute_id" => depute_uid}) do
    depute = Repo.get(An.Depute, depute_uid)
    activities = An.Feed.get_activity_of_depute(depute)

    json(conn, %{data: activities})
  end

  def activity(conn, %{"actor_id" => actor_id, "object_id" => object_id}) do
    actor =
      An.Depute
      |> Repo.get(actor_id)

    object =
      Regex.run(~r/^[a-zA-Z]+/, object_id)
      |> List.first
      |> case do
        "VTANR" -> An.Scrutin
        "QANR" -> An.Question
        "AMANR" -> An.Amendement
      end
      |> Repo.get(object_id)

    activity =
      object
      |> case do
        %An.Question{} -> An.Feed.DeputePoseQuestion.activity_for_depute_question(actor, object)
        %An.Scrutin{} -> An.Feed.DeputeVoteScrutin.activity_for_depute_scrutin(actor, object)
        %An.Amendement{} -> An.Feed.DeputeDeposeAmendement.activity_for_depute_amendement(actor, object)
      end

    json(conn, %{data: activity})
  end
end
