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
    |> Enum.each(fn(dossier) -> handle_dossier(dossier) end)

    # export_data
    # |> Map.get("textesLegislatifs")
    # |> Map.get("document")
    # |> Enum.take(5)
    # |> Enum.each(fn(document) -> handle_document(document) end)
  end

  def handle_dossier(dossier_data) do
    dossier_data = dossier_data |> Map.get("dossierParlementaire")
    dossier = dossier_from_data(dossier_data)

    dossier = case Repo.get_by(DosLeg, uid: dossier.uid) do
      nil  -> dossier
      dossier -> dossier
    end
    |> DosLeg.changeset
    |> Repo.insert_or_update!

    handle_actes_leg(dossier_data, %{dossier_uid: dossier.uid})
  end

  defp dossier_from_data(dossier_data) do
    %DosLeg{
      uid: dossier_data |> Map.get("uid"),
      titre: dossier_data |> Map.get("titreDossier") |> Map.get("titre"),
      raw_json: dossier_data |> Map.delete("actesLegislatifs")
    }
  end

  def handle_actes_leg(acte_leg_data, parent) do
    acte_leg_data
    |> Map.get("actesLegislatifs")
    |> case do
      n when is_nil(n) -> %{acteLegislatif: nil}
      actes -> actes
    end
    |> Map.get("acteLegislatif")
    |> case do
      l when is_list(l) -> l
      n when is_nil(n) -> []
      s -> [s]
    end
    |> Enum.each(fn(acte) -> handle_acte_leg(acte, parent) end)
  end

  def handle_acte_leg(acte_leg_data, parent) do
    acte = acte_from_data(acte_leg_data, parent)

    case Repo.get_by(ActeLeg, uid: acte.uid) do
      nil -> acte
      acte -> acte
    end
    |> ActeLeg.changeset
    |> Repo.insert_or_update!

    handle_actes_leg(acte_leg_data, %{acte_uid: acte.uid})
  end

  defp acte_from_data(acte_leg_data, parent) do
    published_at = case Map.get(acte_leg_data, "dateActe") do
      nil -> nil
      date -> An.Fetcher.AbstractLoader.parse_date(date, "{ISO:Extended}")
    end

    %ActeLeg{
      uid: acte_leg_data |> Map.get("uid"),
      code_acte: acte_leg_data |> Map.get("codeActe"),
      organe_uid: acte_leg_data |> Map.get("organeRef"),
      dossier_uid: parent |> Map.get(:dossier_uid),
      acte_uid: parent |> Map.get(:acte_uid),
      published_at: published_at,
      raw_json: acte_leg_data |> Map.delete("actesLegislatifs")
    }
  end

  def handle_document(document_data) do
    %TexteLeg{
      uid: document_data |> Map.get("uid"),
      raw_json: document_data
    }
    |> Repo.insert!
  end
end
