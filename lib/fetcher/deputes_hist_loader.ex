defmodule An.Fetcher.DeputesHistLoader do
  @behaviour An.Fetcher.AbstractLoader

  @url "AMO/tous_acteurs_mandats_organes_xi_legislature/AMO30_tous_acteurs_tous_mandats_tous_organes_historique.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    An.Fetcher.DeputesLoader.handle_resource(resource_path)
  end
end
