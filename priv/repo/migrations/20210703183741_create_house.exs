defmodule SaltHouses.Repo.Migrations.CreateHouse do
  use Ecto.Migration

  def change do
    create table(:house, primary_key: false) do
      add :id, :serial, primary_key: true
      add :name, :string, null: false
      timestamps()
    end
  end
end
