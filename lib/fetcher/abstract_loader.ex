defmodule An.Fetcher.AbstractLoader do
  @callback get_url() :: String.t
  @callback handle_resource(resource_path :: String.t) :: any

  @an_url "http://data.assemblee-nationale.fr/static/openData/repository/"

  def an_url(url) do
    @an_url <> url
  end

  def unzip(resource_path) do
    {:ok, files} = File.read!(resource_path)
    |> :zip.unzip([:memory])

    {_, content} = List.first(files)
    Poison.Parser.parse!(content)
  end

  def parse_date(date_string) do
    date_string
    |> Timex.parse!("{YYYY}-{0M}-{0D}")
    |> Timex.to_erl
    |> Ecto.DateTime.from_erl
  end
end
