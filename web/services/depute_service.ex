defmodule An.DeputeService do
  import Ecto.Query

  alias An.Commune
  alias An.Depute
  alias An.Mandat
  alias An.Organe
  alias An.Repo

  @spec get_depute_of_commune(number) :: Depute
  def get_depute_of_commune(code_postal) do
    commune =
      Commune
      |> Commune.filter_code_postal(code_postal)
      |> Ecto.Query.first
      |> Repo.one!

    mandat =
      Mandat
      |> Mandat.in_organe(An.OrganeService.current_assemblee)
      |> Mandat.filter_parlementaires
      |> Mandat.filter_circonscription(commune.numero_departement, commune.numero_circonscription)
      |> Mandat.active
      |> Repo.one!
      |> Repo.preload(:depute)

    mandat.depute
  end

  @spec get_parpol_of_depute(Depute) :: Organe
  def get_parpol_of_depute(depute) do
    query =
      from o in Organe,
        join: m in Mandat,
        on: m.depute_uid == ^depute.uid and is_nil(m.date_fin),
        where: o.uid == m.organe_uid,
        where: o.code_type == ^"PARPOL"

    # FIXME: depute can have several PARPOL
    Repo.all(query) |> List.first
  end

  @spec get_gp_of_depute(Depute) :: Organe
  def get_gp_of_depute(depute) do
    query =
      from o in Organe,
        join: m in Mandat,
        on: m.depute_uid == ^depute.uid and is_nil(m.date_fin),
        where: o.uid == m.organe_uid,
        where: o.code_type == ^"GP"

    # FIXME: find a way to use Repo.one (fix data)
    Repo.all(query) |> List.first
  end

  @spec get_mandat_parlementaire_of_depute(Depute) :: Mandat
  def get_mandat_parlementaire_of_depute(depute) do
    depute
    |> Ecto.assoc(:mandats)
    |> Mandat.in_organe(An.OrganeService.current_assemblee)
    |> Mandat.active
    |> Repo.one!
  end

  @spec get_depute_picture(Depute) :: String.t
  def get_depute_picture(depute) do
    "PA" <> picture_id = depute.uid
    "http://www2.assemblee-nationale.fr/static/tribun/14/photos/#{picture_id}.jpg"
  end

  @spec get_president_of_assemblee(Organe) :: Depute
  def get_president_of_assemblee(assemblee) do
    query = from d in Depute,
      join: m in assoc(d, :mandats),
      where: fragment("? #>> ? = ?", m.raw_json, "{infosQualite, libQualite}", "Président de l'Assemblée nationale")
        and m.organe_uid == ^assemblee.uid

    Repo.one!(query)
  end

  @spec search(String.t) :: List
  def search(query) do
    An.OrganeService.current_assemblee
    |> Ecto.assoc(:deputes)
    |> where([d], fragment("(? || ' ' || ?) ILIKE ?", d.prenom, d.nom, ^"%#{query}%"))
    |> Repo.all
  end
end
