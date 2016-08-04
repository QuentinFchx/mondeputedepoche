defmodule An.DeputeService do
  alias An.Commune
  alias An.Depute
  alias An.Mandat
  alias An.Organe
  alias An.Repo

  @spec get_depute_of_commune(number) :: Depute
  def get_depute_of_commune(code_postal) do
    commune = Commune
      |> Commune.filter_code_postal(code_postal)
      |> Ecto.Query.first
      |> Repo.one!

    mandat = Mandat
    |> Mandat.in_organe(Organe.current_assemblee)
    |> Mandat.filter_parlementaires
    |> Mandat.filter_circonscription(commune.numero_departement, commune.numero_circonscription)
    |> Repo.one!
    |> Repo.preload(:depute)

    mandat.depute
  end

  @spec get_parpol_of_depute(Depute) :: Organe
  def get_parpol_of_depute(depute) do
    Ecto.assoc(depute, :organes)
    |> Organe.filter_parpol
    |> Repo.one!
  end

  @spec get_depute_picture(Depute) :: String.t
  def get_depute_picture(depute) do
    "PA" <> picture_id = depute.uid
    "http://www2.assemblee-nationale.fr/static/tribun/14/photos/#{picture_id}.jpg"
  end

  def get_president_of_assemblee(assemblee) do
    assemblee
    |> Repo.preload(:mandats)
  end
end
