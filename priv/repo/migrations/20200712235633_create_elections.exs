defmodule Voting.Repo.Migrations.CreateElections do
  use Ecto.Migration

  def change do
    create table(:elections, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :cover, :string
      add :notice, :string
      add :starts_at, :utc_datetime, null: false
      add :ends_at, :utc_datetime, null: false

      add :created_by_id, references(:administrators, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end

    create index(:elections, [:created_by_id])
  end
end
