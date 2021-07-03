defmodule SaltHouses.Repo.Migrations.CreateHouse do
  use Ecto.Migration

  def change do
    create table(:house, primary_key: false) do
      add :id, :id, primary_key: true
      add :name, :string, null: false
      add :description, :string
      timestamps()
    end
  end
end
