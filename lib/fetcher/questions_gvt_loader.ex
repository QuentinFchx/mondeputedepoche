defmodule An.Fetcher.QuestionsGvtLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.Question
  alias An.Depute
  alias An.Repo

  @url "QUESTIONS/questions_gouvernement/Questions_gouvernement_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    resource_path
    |> An.Fetcher.AbstractLoader.unzip
    |> Map.get("questionsGvt")
    |> Map.get("question")
    |> Enum.each(fn(question) -> handle_question(question) end)
  end

  def handle_question(question_data) do
    question = question_from_data(question_data)

    if Repo.get(Depute, question.depute_uid) do
      case Repo.get(Question, question.uid) do
        nil -> Repo.insert!(question)
        question -> question
      end
    end
  end

  defp question_from_data(question_data) do
    date_cloture =
      question_data
      |> Map.get("cloture")
      |> case do
        nil -> nil
        cloture -> cloture
          |> Map.get("infoJO")
          |> Map.get("dateJO")
          |> An.Fetcher.AbstractLoader.parse_date
      end

    %Question{
      uid: question_data |> Map.get("uid"),
      depute_uid: question_data |> Map.get("auteur") |> Map.get("identite") |> Map.get("acteurRef"),
      type: question_data |> Map.get("type"),
      raw_json: question_data,
      published_at: date_cloture
    }
  end
end
