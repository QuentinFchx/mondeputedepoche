defmodule An.DosLeg do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "dos_legs" do
    field :titre, :string
    field :raw_json, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:titre, :raw_json])
    |> validate_required([:raw_json])
  end
end
