defmodule An.Commune do
  use An.Web, :model

  schema "communes" do
    field :nom, :string
    field :code_postaux, {:array, :integer}
    field :numero_departement, :string
    field :numero_circonscription, :integer
    field :raw_json, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nom, :code_postaux, :numero_circonscription, :numero_departement, :raw_json])
    |> validate_required([:nom, :code_postaux, :numero_circonscription, :numero_departement])
  end

  def filter_code_postal(query, code_postal) do
    from c in query,
      where: ^code_postal in c.code_postaux
  end
end
