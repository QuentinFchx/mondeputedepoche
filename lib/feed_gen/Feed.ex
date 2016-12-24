defmodule An.Feed do
  import Ecto.Query
  use Timex

  alias An.Feed.DeputePoseQuestion
  alias An.Feed.DeputeVoteScrutin
  alias An.Feed.DeputeDeposeAmendement

  @mailbox_size 20

  def generate_feed_for(actors, before \\ DateTime.utc_now()) do
    actors
    |> Stream.map(&Task.async(An.Feed, :get_activity_of_actor, [&1, before]))
    |> Enum.map(&Task.await(&1))
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
    args = [depute, before, @mailbox_size]

    [
      Task.async(DeputePoseQuestion, :get_depute_questions, args),
      Task.async(DeputeVoteScrutin, :get_depute_votes, args),
      Task.async(DeputeDeposeAmendement, :get_depute_amendements, args)
    ]
    |> Enum.map(&Task.await(&1))
    |> List.flatten
    |> Enum.sort(fn(a1, a2) -> Timex.compare(a1.published, a2.published) > 0 end)
    |> Enum.take(@mailbox_size)
  end
end
