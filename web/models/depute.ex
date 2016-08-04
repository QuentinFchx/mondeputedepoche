defmodule An.Depute do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "deputes" do
    field :nom, :string
    field :prenom, :string
    field :date_naissance, :utc_datetime
    field :raw_json, :map

    has_many :mandats, An.Mandat, foreign_key: :depute_uid
    has_many :organes, through: [:mandats, :organe]
    has_many :questions, An.Question, foreign_key: :depute_uid
    has_many :scrutin_votes, An.ScrutinDeputeVote, foreign_key: :depute_uid
    has_many :scrutins, through: [:scrutin_votes, :scrutin]
    has_many :amendements, An.Amendement, foreign_key: :depute_uid

    has_many :citoyen_follows, An.CitoyenFollow, foreign_key: :depute_uid
    has_many :followers, through: [:citoyen_follows, :citoyen]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uid, :nom, :prenom, :date_naissance])
    |> validate_required([:uid, :nom, :prenom, :date_naissance])
    |> unique_constraint(:uid)
  end

  def find_by_name(query, name) do
    from d in query,
      where: fragment("(prenom || ' ' || nom) = ?", ^name)
  end

  def search(query, search) do
    from d in query,
      where: fragment("(prenom || ' ' || nom) ILIKE ?", ^"%#{search}%")
  end

  def president_of_assemblee(assemblee) do
    query = from d in __MODULE__,
      join: m in assoc(d, :mandats),
      where: fragment("? #>> ? = ?", m.raw_json, "{infosQualite, libQualite}", "Président de l'Assemblée nationale")
        and m.organe_uid == ^assemblee.uid

    An.Repo.one!(query)
  end
end
