defmodule An.Repo.Migrations.CreateScrutinDeputeVote do
  use Ecto.Migration

  def change do
    execute("create type vote_type as enum ('pour', 'contre', 'abstention', 'non_votant')")

    create table(:scrutin_depute_votes, primary_key: false) do
      add :scrutin_uid, references(:scrutins, column: :uid, type: :string, on_delete: :nothing), null: false, primary_key: true
      add :depute_uid, references(:deputes, column: :uid, type: :string, on_delete: :nothing), null: false, primary_key: true
      add :type, :vote_type, null: false

      timestamps()
    end
    create index(:scrutin_depute_votes, [:scrutin_uid])
    create index(:scrutin_depute_votes, [:depute_uid])

  end
end
