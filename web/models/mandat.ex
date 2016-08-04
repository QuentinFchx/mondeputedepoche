defmodule An.Mandat do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "mandats" do
    belongs_to :depute, An.Depute, foreign_key: :depute_uid, references: :uid, type: :string
    belongs_to :organe, An.Organe, foreign_key: :organe_uid, references: :uid, type: :string
    field :date_debut, :utc_datetime
    field :date_fin, :utc_datetime
    field :raw_json, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:depute_uid, :organe_uid])
    |> cast_assoc(:depute)
    |> cast_assoc(:organe)
    |> assoc_constraint(:depute)
    |> assoc_constraint(:organe)
  end

  def filter_parlementaires(query) do
    from m in query,
      where: fragment("? @> ?", m.raw_json, "{\"@xsi:type\":\"MandatParlementaire_type\"}")
  end

  def of_depute(query, depute) do
    from m in query,
      join: d in assoc(m, :depute),
      where: d.uid == ^depute.uid
  end

  def in_organe(query, organe) do
    from m in query,
      join: o in assoc(m, :organe),
      where: o.uid == ^organe.uid
  end

  def filter_circonscription(query, numero_departement, numero_circonscription) do
    numero_circonscription_str = Integer.to_string(numero_circonscription)
    from m in query,
      where: fragment("? #>> ? = ?", m.raw_json, "{election, lieu, numDepartement}", ^numero_departement)
        and fragment("? #>> ? = ?", m.raw_json, "{election, lieu, numCirco}", ^numero_circonscription_str)
  end
end
