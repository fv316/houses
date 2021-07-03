defmodule SaltHouses.House.Schemas.Member do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias SaltHouses.House.Schemas.House

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :id
  schema "member" do
    field :name, :string, null: false
    field :date_of_birth, :date
    field :active?, :boolean, null: false, default: true

    belongs_to :house, House,
      foreign_key: :house_id,
      primary_key: false,
      type: :id

    timestamps()
  end

  def insert_changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, [
      :name,
      :date_of_birth,
      :house_id,
      :active?
    ])
    |> assign_house()
    |> foreign_key_constraint(:house_id)
    |> validate_required([
      :name,
      :date_of_birth,
      :house_id
    ])
  end

  def assign_house(changeset) do
    if changeset.valid? do
      _assign_house(changeset)
    else
      changeset
    end
  end

  def _assign_house(%{house_id: _} = changeset), do: changeset
  def _assign_house(changeset), do: put_change(changeset, :house_id, House.assign_house())
end
