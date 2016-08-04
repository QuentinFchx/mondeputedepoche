defmodule An.Repo.Migrations.CreateAmendement do
  use Ecto.Migration

  def change do
    create table(:amendements, primary_key: false) do
      add :uid, :string, primary_key: true
      add :depute_uid, references(:deputes, column: :uid, type: :string, on_delete: :nothing), null: false
      add :raw_json, :map

      timestamps()
    end
    create index(:amendements, [:depute_uid])

  end
end
