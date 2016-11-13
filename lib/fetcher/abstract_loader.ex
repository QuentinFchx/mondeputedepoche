defmodule An.Fetcher.AbstractLoader do
  require Logger

  @callback get_url() :: String.t
  @callback handle_resource(resource_path :: String.t) :: any

  @an_url "http://data.assemblee-nationale.fr/static/openData/repository/"

  def an_url(url) do
    @an_url <> url
  end

  def unzip(resource_path) do
    Logger.info("Unzipping " <> resource_path)
    {:ok, files} = File.read!(resource_path)
    |> :zip.unzip([:memory])
    Logger.info("Unzipped " <> resource_path)

    {_, content} = List.first(files)
    Logger.info("Parsing " <> resource_path)
    Poison.Parser.parse!(content)
  end

  def parse_date(date_string, format \\ "{YYYY}-{0M}-{0D}") do
    date_string
    |> Timex.parse!(format)
    |> Timex.to_erl
    |> Ecto.DateTime.from_erl
  end
end
