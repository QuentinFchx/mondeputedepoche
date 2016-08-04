defmodule An.Repo.Migrations.CreateCommune do
  use Ecto.Migration

  def change do
    create table(:communes) do
      add :nom, :string
      add :code_postaux, {:array, :integer}
      add :numero_departement, :string
      add :numero_circonscription, :integer
      add :raw_json, :map

      timestamps()
    end

  end
end
