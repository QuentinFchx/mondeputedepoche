defmodule An.Fetcher.DeputesLoader do
  @behaviour An.Fetcher.AbstractLoader

  alias An.Depute
  alias An.Organe
  alias An.Mandat
  alias An.Repo

  @url "AMO/deputes_actifs_mandats_actifs_organes/AMO10_deputes_actifs_mandats_actifs_organes_XIV.json.zip"

  def get_url do
    An.Fetcher.AbstractLoader.an_url(@url)
  end

  def handle_resource(resource_path) do
    export_data =
      resource_path
      |> An.Fetcher.AbstractLoader.unzip
      |> Map.get("export")

    load_organes(export_data)
    load_acteurs(export_data)
  end

  # DEPUTES

  defp load_acteurs(export_data) do
    export_data
    |> Map.get("acteurs")
    |> Map.get("acteur")
    |> Enum.each(fn(acteur) -> handle_acteur(acteur) end)
  end

  defp handle_acteur(depute_data) do
    depute = depute_data |> depute_from_data

    depute = case Repo.get_by(Depute, uid: depute.uid) do
      nil  -> depute
      depute -> depute
    end
    |> Depute.changeset
    |> Repo.insert_or_update!

    depute_data
    |> Map.get("mandats")
    |> Map.get("mandat")
    |> Enum.each(fn(mandat) -> handle_mandat(depute, mandat) end)
  end

  defp depute_from_data(depute_data) do
    etat_civil = depute_data |> Map.get("etatCivil")
    identite = etat_civil |> Map.get("ident")

    date_naissance = etat_civil
    |> Map.get("infoNaissance")
    |> Map.get("dateNais")
    |> An.Fetcher.AbstractLoader.parse_date

    %Depute{
      uid: depute_data |> Map.get("uid") |> Map.get("#text"),
      nom: identite |> Map.get("nom"),
      prenom: identite |> Map.get("prenom"),
      date_naissance: date_naissance,
      raw_json: depute_data |> Map.delete("mandats")
    }
  end

  # MANDATS

  defp handle_mandat(depute, mandat_data) do
    mandat = mandat_from_data(depute, mandat_data)

    case Repo.get_by(Mandat, uid: mandat.uid) do
      nil  -> mandat
      mandat -> mandat
    end
    |> Repo.preload([:depute, :organe])
    |> Mandat.changeset
    |> Repo.insert_or_update!
  end

  defp mandat_from_data(depute, mandat_data) do
    organes_ref =
      mandat_data
      |> Map.get("organes")
      |> Map.get("organeRef")

    # FIXME (several organes ?)
    organe_uid = case organes_ref do
      l when is_list(l) -> l |> List.first
      single -> single
    end

    date_debut =
      mandat_data
      |> Map.get("dateDebut")
      |> An.Fetcher.AbstractLoader.parse_date

    date_fin_str = Map.get(mandat_data, "dateFin")
    date_fin = case date_fin_str do
      n when is_nil(n) -> nil
      _ -> An.Fetcher.AbstractLoader.parse_date(date_fin_str)
    end

    %Mandat{
      uid: mandat_data |> Map.get("uid"),
      depute_uid: depute.uid,
      organe_uid: organe_uid,
      date_debut: date_debut,
      date_fin: date_fin,
      raw_json: mandat_data
    }
  end

  # ORGANES

  defp load_organes(export_data) do
    export_data
    |> Map.get("organes")
    |> Map.get("organe")
    |> Enum.each(fn(organe) -> handle_organe(organe) end)
  end

  defp handle_organe(organe_data) do
    organe = organe_data |> organe_from_data

    case Repo.get(Organe, organe.uid) do
      nil  -> organe
      organe -> organe
    end
    |> Organe.changeset
    |> Repo.insert_or_update!
  end

  defp organe_from_data(organe_data) do
    %Organe{
      uid: organe_data |> Map.get("uid"),
      type: organe_data |> Map.get("@xsi:type"),
      code_type: organe_data |> Map.get("codeType"),
      libelle: organe_data |> Map.get("libelle"),
      raw_json: organe_data
    }
  end
end
