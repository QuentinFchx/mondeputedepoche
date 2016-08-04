defmodule An.Question do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "questions" do
    field :type, :string
    field :raw_json, :map
    field :published_at, :utc_datetime

    belongs_to :depute, An.Depute, foreign_key: :depute_uid, references: :uid, type: :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type])
    |> validate_required([:type])
    |> unique_constraint(:uid)
  end
end
