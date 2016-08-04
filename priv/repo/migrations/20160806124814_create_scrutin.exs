defmodule An.Repo.Migrations.CreateScrutin do
  use Ecto.Migration

  def change do
    execute("create type scrutin_sort as enum ('adopté', 'rejeté')")

    create table(:scrutins, primary_key: false) do
      add :uid, :string, primary_key: true
      add :titre, :text
      add :sort, :scrutin_sort, null: false
      add :raw_json, :map
      add :published_at, :utc_datetime, null: false

      timestamps()
    end
  end
end
