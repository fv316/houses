defmodule SaltHouses.Repo.Migrations.CreateHouse do
  use Ecto.Migration

  def change do
    create table(:house, primary_key: false) do
      add :id, :id, primary_key: true
      field(:name, :string, null: false)
      field(:description, :string)
      timestamps()
    end
  end
end
