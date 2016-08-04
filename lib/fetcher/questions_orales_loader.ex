defmodule An.Fetcher.QuestionsOralesLoader do
  @behaviour An.Fetcher.AbstractLoader

  @url "QUESTIONS/questions_orales_sans_debat/Questions_orales_sans_debat_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    resource_path
    |> An.Fetcher.AbstractLoader.unzip
    |> Map.get("questionsOralesSansDebat")
    |> Map.get("question")
    |> Enum.each(fn(question) -> An.Fetcher.QuestionsGvtLoader.handle_question(question) end)
  end
end
