defmodule An.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    execute("create type question_type as enum ('QE', 'QG', 'QOSD')")

    create table(:questions, primary_key: false) do
      add :uid, :string, primary_key: true
      add :depute_uid, references(:deputes, column: :uid, type: :string, on_delete: :nothing), null: false
      add :type, :question_type, null: false
      add :raw_json, :map
      add :published_at, :utc_datetime, null: false

      timestamps()
    end

    create index(:questions, [:depute_uid])
  end
end
