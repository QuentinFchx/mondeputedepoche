defmodule An.Fetcher do
  require Logger

  alias An.Fetcher.CirconscriptionsLoader
  alias An.Fetcher.DeputesLoader
  alias An.Fetcher.DeputesHistLoader
  alias An.Fetcher.DeputesSenateursMinistresLoader
  alias An.Fetcher.DoslegsLoader
  alias An.Fetcher.ScrutinsLoader
  alias An.Fetcher.QuestionsGvtLoader
  alias An.Fetcher.QuestionsEcritesLoader
  alias An.Fetcher.QuestionsOralesLoader
  alias An.Fetcher.AmendementsLoader

  @data_folder "data/"

  def fetch_all do
    [
      DeputesSenateursMinistresLoader,
      QuestionsGvtLoader,
      QuestionsOralesLoader,
      ScrutinsLoader
    ]
    |> Enum.each(fn(loader) -> fetch_one(loader) end)
  end

  def fetch_one(loader)do
    loader.get_url
    |> fetch_url
    |> loader.handle_resource
  end

  defp fetch_url(url) do
    file_name = url |> String.split("/") |> List.last
    output = @data_folder <> file_name

    Logger.info("Fetching " <> url)
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    File.write!(output, body)
    Logger.info("Fetched")

    output
  end
end
