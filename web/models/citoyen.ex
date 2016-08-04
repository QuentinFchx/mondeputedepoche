defmodule An.Citoyen do
  use An.Web, :model

  schema "citoyens" do
    has_many :citoyen_follows, An.CitoyenFollow, foreign_key: :citoyen_uid
    has_many :followed, through: [:citoyen_follows, :depute]

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
