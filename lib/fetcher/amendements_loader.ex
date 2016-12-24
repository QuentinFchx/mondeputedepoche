defmodule An.Fetcher.AmendementsLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.Amendement
  alias An.Repo

  @url "LOI/amendements_legis/Amendements_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    resource_path
    |> An.Fetcher.AbstractLoader.unzip
    |> Map.get("textesEtAmendements")
    |> Map.get("texteleg")
    |> Enum.take(2)
    |> Enum.map(fn(textleg) -> handle_texte_leg(textleg) end)
  end

  defp handle_texte_leg(textleg) do
    textleg
    |> Map.get("amendements")
    |> Map.get("amendement")
    |> Enum.map(fn(amendement) -> handle_amendement(amendement) end)
  end

  defp handle_amendement(amendement_data) do
    amendement = amendement_from_data(amendement_data)

    case Repo.get_by(Amendement, uid: amendement.uid) do
      nil -> amendement |> Repo.insert!
    end
  end

  defp amendement_from_data(amendement_data) do
    signataires = amendement_data |> Map.get("signataires")
    auteur = signataires |> Map.get("auteur")
    # FIXME: handle co-signataires
    cosignataires = signataires |> Map.get("cosignataires")

    date_depot =
      amendement_data
      |> Map.get("dateDepot")
      |> An.Fetcher.AbstractLoader.parse_date

    %Amendement{
      uid: amendement_data |> Map.get("uid"),
      depute_uid: auteur |> Map.get("acteurRef"),
      etat: amendement_data |> Map.get("etat"),
      published_at: date_depot,
      raw_json: amendement_data
    }
  end
end
