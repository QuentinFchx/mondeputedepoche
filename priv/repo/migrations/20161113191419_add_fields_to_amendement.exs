defmodule An.Repo.Migrations.AddFieldsToAmendement do
  use Ecto.Migration

  def change do
    alter table(:amendements) do
      add :etat, :string
      add :published_at, :utc_datetime
    end
  end
end
