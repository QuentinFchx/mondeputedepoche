defmodule An.Repo.Migrations.AddUniqueFollowConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:citoyen_follows, [:citoyen_uid, :depute_uid])

  end
end
