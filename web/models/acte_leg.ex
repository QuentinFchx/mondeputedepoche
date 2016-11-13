defmodule An.ActeLeg do
  use An.Web, :model

  @primary_key {:uid, :string, []}
  schema "actes_legs" do
    field :code_acte, :string
    field :raw_json, :map
    field :published_at, :utc_datetime

    belongs_to :organe, An.Organe, foreign_key: :organe_uid, references: :uid, type: :string
    belongs_to :dossier, An.DosLeg, foreign_key: :dossier_uid, references: :uid, type: :string
    belongs_to :acte_parent, An.ActeLeg, foreign_key: :acte_uid, references: :uid, type: :string

    has_many :actes_enfant, An.ActeLeg, foreign_key: :acte_uid

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:code_acte, :raw_json])
    |> validate_required([:raw_json])
  end
end
