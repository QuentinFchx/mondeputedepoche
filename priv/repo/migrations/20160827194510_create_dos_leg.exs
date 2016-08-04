defmodule An.Repo.Migrations.CreateDosLeg do
  use Ecto.Migration

  def change do
    create table(:dos_legs, primary_key: false) do
      add :uid, :string, primary_key: true
      add :raw_json, :map

      timestamps()
    end

  end
end
