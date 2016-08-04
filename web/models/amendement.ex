defmodule An.Amendement do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "amendements" do
    belongs_to :depute, An.Depute, foreign_key: :depute_uid, references: :uid, type: :string
    field :raw_json, :map

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
