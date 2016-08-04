defmodule An.Fetcher.DoslegsLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.DosLeg
  alias An.ActeLeg
  alias An.TexteLeg
  alias An.Repo

  @url "LOI/dossiers_legislatifs/Dossiers_Legislatifs_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    export_data =
      resource_path
      |> An.Fetcher.AbstractLoader.unzip
      |> Map.get("export")

    export_data
    |> Map.get("dossiersLegislatifs")
    |> Map.get("dossier")
    |> Enum.take(5)
    |> Enum.each(fn(dossier) -> handle_dossier(dossier) end)

    export_data
    |> Map.get("textesLegislatifs")
    |> Map.get("document")
    |> Enum.take(5)
    |> Enum.each(fn(document) -> handle_document(document) end)
  end

  def handle_dossier(dossier_data) do
    dossier_data = dossier_data |> Map.get("dossierParlementaire")
    %DosLeg{
      uid: dossier_data |> Map.get("uid"),
      raw_json: dossier_data
    }
    |> Repo.insert!

    handle_acte_leg(dossier_data)
  end

  def handle_acte_leg(acte_leg_data) do
    if is_nil(Map.get(acte_leg_data, "titreDossier")) do
      %ActeLeg{
        uid: acte_leg_data |> Map.get("uid"),
        raw_json: acte_leg_data
      }
      |> Repo.insert!
    end

    actes_legislatifs = case Map.get(acte_leg_data, "actesLegislatifs") do
      n when is_nil(n) -> %{acteLegislatif: nil}
      actes -> actes
    end

    case Map.get(actes_legislatifs, "acteLegislatif") do
      l when is_list(l) -> l
      n when is_nil(n) -> []
      s -> [s]
    end
    |> Enum.each(fn(acte) -> handle_acte_leg(acte) end)
  end

  def handle_document(document_data) do
    %TexteLeg{
      uid: document_data |> Map.get("uid"),
      raw_json: document_data
    }
    |> Repo.insert!
  end
end
