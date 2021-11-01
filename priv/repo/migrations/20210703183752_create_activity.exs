defmodule SaltHouses.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activity, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string
      add :points, :integer, null: false
      add :active?, :boolean, null: false, default: true
      timestamps()
    end
  end
end
