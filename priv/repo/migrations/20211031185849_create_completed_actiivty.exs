defmodule SaltHouses.Repo.Migrations.CreateCompletedActivity do
  use Ecto.Migration

  def change do
    create table(:completed_activity, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing)
      add :activity_id, references(:activity, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
  end
end
