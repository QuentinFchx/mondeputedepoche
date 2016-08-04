defmodule An.Feed do
  import Ecto.Query
  use Timex

  alias An.Feed.DeputePoseQuestion
  alias An.Feed.DeputeVoteScrutin
  alias An.Feed.DeputeDeposeAmendement

  @mailbox_size 20

  def generate_feed_for(actors, before \\ DateTime.utc_now()) do
    actors
    |> Enum.map(fn(actor) -> get_activity_of_actor(actor, before) end)
    |> List.flatten
    |> Enum.sort(fn(a1, a2) -> Timex.compare(a1.published, a2.published) > 0 end)
    |> Enum.take(@mailbox_size)
  end

  def get_activity_of_actor(actor, before \\ DateTime.utc_now()) do
    case actor do
      %An.Depute{} -> get_activity_of_depute(actor, before)
    end
  end

  def get_activity_of_depute(depute, before \\ DateTime.utc_now()) do
    questions = DeputePoseQuestion.get_depute_questions(depute, before, @mailbox_size)
    votes = DeputeVoteScrutin.get_depute_votes(depute, before, @mailbox_size)

    questions ++ votes
    |> Enum.sort(fn(a1, a2) -> Timex.compare(a1.published, a2.published) > 0 end)
    |> Enum.take(@mailbox_size)
  end
end
