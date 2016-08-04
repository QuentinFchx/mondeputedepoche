defmodule An.Repo.Migrations.CreateOrgane do
  use Ecto.Migration

  def change do
    create table(:organes, primary_key: false) do
      add :uid, :string, primary_key: true
      add :type, :string, null: false
      add :code_type, :string, null: false
      add :libelle, :string
      add :raw_json, :map


      timestamps()
    end
  end
end
