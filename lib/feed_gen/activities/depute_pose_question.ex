defmodule An.Feed.DeputePoseQuestion do
  import Ecto.Query

  alias An.Activity
  alias An.Repo

  def get_depute_questions(depute, before \\ DateTime.utc_now(), limit \\ 20) do
    depute
    |> Ecto.assoc(:questions)
    |> where([q], q.published_at < ^before)
    |> order_by(desc: :published_at)
    |> limit(^limit)
    |> Repo.all
    |> Enum.map(fn(question) -> activity_for_depute_question(depute, question) end)
  end

  def activity_for_depute_question(depute, question) do
    %Activity{
      actor: Activity.depute_to_actor(depute),
      verb: "pose_question",
      object: Activity.question_to_object(question),
      published: question.published_at
    }
  end
end
