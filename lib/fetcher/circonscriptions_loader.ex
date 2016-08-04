defmodule An.Fetcher.CirconscriptionsLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.Commune
  alias An.Repo

  @url "http://www.nosdonnees.fr/wiki/images/b/b5/EUCircos_Regions_departements_circonscriptions_communes_gps.csv.gz"

  def get_url do
    @url
  end

  def handle_resource(resource_path) do
    csv =
      File.open!(resource_path, [:compressed])
      |> IO.binread(:all)

    tmp_path = "tmp.csv"

    # FIXME: do not use tmp file
    File.write(tmp_path, csv)

    File.stream!(tmp_path)
    |> CSV.decode(separator: ?;, headers: true)
    |> Enum.each(fn(commune_row) -> handle_commune(commune_row) end)

    File.rm!(tmp_path)
  end

  defp handle_commune(commune_row) do
    commune_from_row(commune_row)
    |> Repo.insert!
  end

  defp commune_from_row(commune_row) do
    code_postaux =
      case commune_row |> Map.get("codes_postaux") |> String.trim |> String.split(" ") do
        l when is_list(l) -> l
        s when is_bitstring(s) -> [s]
      end
      |> Enum.map(fn(cp) -> String.to_integer(cp) end)

    %Commune{
      nom: commune_row |> Map.get("nom_commune"),
      code_postaux: code_postaux,
      numero_departement: commune_row |> Map.get("numéro_département"),
      numero_circonscription: commune_row |> Map.get("numéro_circonscription") |> String.to_integer,
      raw_json: commune_row
    }
  end
end
