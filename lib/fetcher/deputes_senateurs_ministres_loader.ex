defmodule An.Fetcher.DeputesSenateursMinistresLoader do
  @behaviour An.Fetcher.AbstractLoader

  @url "AMO/deputes_senateurs_ministres_legislature/AMO20_dep_sen_min_tous_mandats_et_organes_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    An.Fetcher.DeputesLoader.handle_resource(resource_path)
  end
end
