defmodule An.CitoyenFollow do
  use An.Web, :model

  schema "citoyen_follows" do
    belongs_to :citoyen, An.Citoyen, foreign_key: :citoyen_uid
    belongs_to :depute, An.Depute, foreign_key: :depute_uid, references: :uid, type: :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
