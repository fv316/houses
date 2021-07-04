defmodule SaltHouses.House.Schemas.CompletedActivity do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias SaltHouses.House.Schemas.{Activity, Member}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "completed_activity" do
    field :form, :map, null: false

    belongs_to :activity, Activity,
      foreign_key: :activity_id,
      primary_key: false,
      type: :binary_id

    belongs_to :member, Member,
      foreign_key: :member_id,
      primary_key: false,
      type: :binary_id

    timestamps()
  end

  def insert_changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(completed_activity, attrs) do
    completed_activity
    |> cast(attrs, [
      :member_id,
      :activity_id,
      :form
    ])
    |> foreign_key_constraint(:member_id)
    |> foreign_key_constraint(:activity_id)
    |> validate_required([
      :member_id,
      :activity_id,
      :form
    ])
  end
end
