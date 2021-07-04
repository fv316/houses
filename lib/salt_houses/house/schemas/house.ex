defmodule SaltHouses.House.Schemas.House do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias SaltHouses.House.Data

  @primary_key {:id, :id, autogenerate: true}
  @foreign_key_type :id
  schema "house" do
    field :name, :string, null: false
    field :description, :string
    timestamps()
  end

  def insert_changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(house, attrs) do
    house
    |> cast(attrs, [
      :name,
      :description
    ])
    |> validate_required([
      :name
    ])
  end

  def assign_house() do
    case Data.get_all_houses() do
      {:ok, houses} -> :rand.uniform(length(houses))
      e -> e
    end
  end
end
