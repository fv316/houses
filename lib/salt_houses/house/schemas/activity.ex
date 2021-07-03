defmodule SaltHouses.House.Schemas.Activity do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "activity" do
    field :name, :string, null: false
    field :description, :string
    field :form, :map, null: false
    field :points, :integer, null: false
    field :active?, :boolean, null: false, default: true
    timestamps()
  end

  def insert_changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(house, attrs) do
    house
    |> cast(attrs, [
      :name,
      :description,
      :form,
      :points,
      :active?
    ])
    |> validate_required([
      :name,
      :description,
      :form,
      :points
    ])
  end
end
