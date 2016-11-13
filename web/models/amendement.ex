defmodule An.Amendement do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "amendements" do
    field :etat, :string
    field :published_at, :utc_datetime
    field :raw_json, :map

    belongs_to :depute, An.Depute, foreign_key: :depute_uid, references: :uid, type: :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:raw_json])
    |> validate_required([:raw_json])
  end
end
