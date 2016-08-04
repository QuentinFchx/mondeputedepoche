defmodule An.Repo.Migrations.CreateDepute do
  use Ecto.Migration

  def change do
    create table(:deputes, primary_key: false) do
      add :uid, :string, primary_key: true
      add :nom, :string
      add :prenom, :string
      add :date_naissance, :utc_datetime
      add :raw_json, :map

      timestamps()
    end
  end
end
