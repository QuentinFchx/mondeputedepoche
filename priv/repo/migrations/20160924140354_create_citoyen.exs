defmodule An.Repo.Migrations.CreateCitoyen do
  use Ecto.Migration

  def change do
    create table(:citoyens) do

      timestamps()
    end

  end
end
