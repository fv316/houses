defmodule SaltHouses.Schemas.House do
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
      :name,
      :description
    ])
  end

  def assign_house() do
    case Data.get_house_count() do
      {:ok, n} -> :rand.uniform(n)
      e -> e
    end
  end
end
