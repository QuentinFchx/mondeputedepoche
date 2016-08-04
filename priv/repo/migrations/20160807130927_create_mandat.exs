defmodule An.Repo.Migrations.CreateMandat do
  use Ecto.Migration

  def change do
    create table(:mandats, primary_key: false) do
      add :uid, :string, primary_key: true
      add :depute_uid, references(:deputes, column: :uid, type: :string, on_delete: :nothing), null: false
      add :organe_uid, references(:organes, column: :uid, type: :string, on_delete: :nothing), null: false
      add :date_debut, :utc_datetime, null: false
      add :date_fin, :utc_datetime
      add :raw_json, :map

      timestamps()
    end

    create index(:mandats, [:depute_uid])
  end
end
