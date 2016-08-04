defmodule An.Repo.Migrations.CreateCitoyenFollow do
  use Ecto.Migration

  def change do
    create table(:citoyen_follows) do
      add :citoyen_uid, references(:citoyens, on_delete: :nothing), null: false
      add :depute_uid, references(:deputes, column: :uid, type: :string, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:citoyen_follows, [:citoyen_uid])
    create index(:citoyen_follows, [:depute_uid])

  end
end
