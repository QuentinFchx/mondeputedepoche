defmodule An.Repo.Migrations.AddFieldsToActeLeg do
  use Ecto.Migration

  def change do
    alter table(:actes_legs) do
      add :code_acte, :string
      add :organe_uid, references(:organes, column: :uid, type: :string, on_delete: :nothing)
      add :dossier_uid, references(:dos_legs, column: :uid, type: :string, on_delete: :nothing)
      add :acte_uid, references(:actes_legs, column: :uid, type: :string, on_delete: :nothing)
      add :published_at, :utc_datetime
    end

    create index(:actes_legs, [:organe_uid])
    create index(:actes_legs, [:dossier_uid])
    create index(:actes_legs, [:acte_uid])
  end
end
