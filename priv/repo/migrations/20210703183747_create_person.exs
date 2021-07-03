defmodule SaltHouses.Repo.Migrations.CreateMember do
  use Ecto.Migration

  def change do
    create table(:member, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :date_of_birth, :date
      add :active?, :boolean, null: false, default: true
      add :house_id, references(:house, on_delete: :nothing, type: :id)

      timestamps()
    end
  end
end
