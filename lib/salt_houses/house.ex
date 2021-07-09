defmodule SaltHouses.House do
  alias SaltHouses.House.Data

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(SaltHouses.PubSub, @topic)
  end

  def broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(SaltHouses.PubSub, @topic, {__MODULE__, event, result})
  end

  def get_house_points(), do: Data.get_house_points()

  def get_member_points(), do: Data.get_member_points()

  def get_activities() do
    case Data.get_all_activities() do
      {:ok, records} -> records
      e -> e
    end
  end

  def get_members() do
    case Data.get_all_members() do
      {:ok, records} -> records
      e -> e
    end
  end

  def complete_activity(member_id, activity_id, form \\ %{}) do
    Data.create_completed_activity(%{member_id: member_id, activity_id: activity_id, form: form})
    |> broadcast_change([:comleted_activity, :created])
  end

  alias SaltHouses.House.Schemas.Activity
  alias SaltHouses.Repo

  @doc """
  Returns the list of activities.

  ## Examples

      iex> list_activities()
      [%Activity{}, ...]

  """
  def list_activities do
    Repo.all(Activity)
  end

  @doc """
  Gets a single activity.

  Raises `Ecto.NoResultsError` if the Activity does not exist.

  ## Examples

      iex> get_activity!(123)
      %Activity{}

      iex> get_activity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_activity!(id), do: Repo.get!(Activity, id)

  @doc """
  Creates a activity.

  ## Examples

      iex> create_activity(%{field: value})
      {:ok, %Activity{}}

      iex> create_activity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_activity(attrs \\ %{}) do
    %Activity{}
    |> Activity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a activity.

  ## Examples

      iex> update_activity(activity, %{field: new_value})
      {:ok, %Activity{}}

      iex> update_activity(activity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_activity(%Activity{} = activity, attrs) do
    activity
    |> Activity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a activity.

  ## Examples

      iex> delete_activity(activity)
      {:ok, %Activity{}}

      iex> delete_activity(activity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_activity(%Activity{} = activity) do
    Repo.delete(activity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking activity changes.

  ## Examples

      iex> change_activity(activity)
      %Ecto.Changeset{data: %Activity{}}

  """
  def change_activity(%Activity{} = activity, attrs \\ %{}) do
    Activity.changeset(activity, attrs)
  end
end
