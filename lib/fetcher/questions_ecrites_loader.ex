defmodule An.Fetcher.QuestionsEcritesLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.Question
  alias An.Repo

  @url "QUESTIONS/questions_ecrites/Questions_ecrites_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    resource_path
    |> An.Fetcher.AbstractLoader.unzip
    |> Map.get("questionsEcrites")
    |> Map.get("question")
    |> Enum.each(fn(scrutin) -> handle_question(scrutin) end)
  end

  defp handle_question(question_data) do
    question = question_from_data(question_data)

    case Repo.get(Question, question.uid) do
      nil -> Repo.insert!(question)
      question -> question
    end
  end

  defp question_from_data(question_data) do
    date_cloture =
      question_data
      |> Map.get("textesQuestion")
      |> Map.get("texteQuestion")
      |> case do
        l when is_list(l) -> List.first(l)
        single -> single
      end
      |> Map.get("infoJO")
      |> Map.get("dateJO")
      |> An.Fetcher.AbstractLoader.parse_date

    %Question{
      uid: question_data |> Map.get("uid"),
      depute_uid: question_data |> Map.get("auteur") |> Map.get("identite") |> Map.get("acteurRef"),
      type: question_data |> Map.get("type"),
      raw_json: question_data,
      published_at: date_cloture
    }
  end
end
