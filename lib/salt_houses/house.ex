defmodule SaltHouses.House do
  alias SaltHouses.House.Data

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(SaltHouses.PubSub, @topic)
  end

  def broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(SaltHouses.PubSub, @topic, {__MODULE__, event, result})
  end

  def get_points(), do: Data.get_house_points()

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
end
