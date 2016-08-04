defmodule An.ScrutinDeputeVote do
  use An.Web, :model

  @primary_key false
  schema "scrutin_depute_votes" do
    belongs_to :scrutin, An.Scrutin, foreign_key: :scrutin_uid, references: :uid, type: :string, primary_key: true
    belongs_to :depute, An.Depute, foreign_key: :depute_uid, references: :uid, type: :string, primary_key: true
    field :type, :string

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
