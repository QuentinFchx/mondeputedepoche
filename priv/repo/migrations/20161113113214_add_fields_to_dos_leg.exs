defmodule An.Repo.Migrations.AddFieldsToDosLeg do
  use Ecto.Migration

  def change do
    alter table(:dos_legs) do
      add :titre, :text
    end
  end
end
