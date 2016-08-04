defmodule An.Repo.Migrations.CreateActeLeg do
  use Ecto.Migration

  def change do
    create table(:actes_legs, primary_key: false) do
      add :uid, :string, primary_key: true
      add :raw_json, :map

      timestamps()
    end

  end
end
