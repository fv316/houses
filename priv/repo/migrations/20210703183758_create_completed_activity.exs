defmodule SaltHouses.Repo.Migrations.CreateCompletedActivity do
  use Ecto.Migration

  def change do
    create table(:completed_activity, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :member_id, references(:member, on_delete: :nothing, type: :binary_id)
      add :activity_id, references(:activity, on_delete: :nothing, type: :binary_id)
      add :form, :map, null: false

      timestamps()
    end
  end
end
