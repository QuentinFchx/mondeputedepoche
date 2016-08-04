defmodule An.Scrutin do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "scrutins" do
    field :titre, :string
    field :sort, :string
    field :raw_json, :map
    field :published_at, :utc_datetime

    has_many :scrutin_depute_votes, An.ScrutinDeputeVote, foreign_key: :scrutin_uid, references: :uid

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:titre, :raw_json])
    |> validate_required([:titre, :raw_json])
  end
end
