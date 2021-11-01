defmodule SaltHouses.Houses do
  import Ecto.Query

  alias SaltHouses.Repo
  alias SaltHouses.Accounts.User
  alias SaltHouses.Houses.Schemas.{Activity, CompletedActivity, House}

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(SaltHouses.PubSub, @topic)
  end

  def broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(SaltHouses.PubSub, @topic, {__MODULE__, event, result})
  end

  def get_house_points do
    CompletedActivity
    |> join(:inner, [c], a in Activity, on: c.activity_id == a.id)
    |> join(:inner, [c, a], m in User, on: c.user_id == m.id)
    |> join(:inner, [c, a, m], h in House, on: m.house_id == h.id)
    |> group_by([c, a, m, h], h.name)
    |> select([c, a, m, h], %{name: h.name, points: sum(a.points)})
    |> order_by([c, a, m, h], desc: sum(a.points))
    |> Repo.all()
  end

  def get_user_points do
    CompletedActivity
    |> join(:inner, [c], a in Activity, on: c.activity_id == a.id)
    |> join(:inner, [c, a], m in User, on: c.user_id == m.id)
    |> group_by([c, a, m], m.name)
    |> select([c, a, m], %{name: m.name, points: sum(a.points)})
    |> order_by([c, a, m], desc: sum(a.points))
    |> Repo.all()
  end

  def get_activities() do
    case Activity |> Repo.all() do
      [] -> {:error, :none}
      records -> {:ok, records}
    end
  end

  def complete_activity(user_id, activity_id \\ %{}) do
    %{user_id: user_id, activity_id: activity_id}
    |> CompletedActivity.insert_changeset()
    |> Repo.insert()
    |> broadcast_change([:comleted_activity, :created])
  end


  def list_activities do
    Repo.all(Activity)
  end

  def get_activity!(id) do
    Repo.get!(Activity, id)
  end

  def create_activity(attrs \\ %{}) do
    attrs
    |> Activity.insert_changeset()
    |> Repo.insert()
  end

  def update_activity(%Activity{} = activity, attrs) do
    activity
    |> Activity.changeset(attrs)
    |> Repo.update()
  end

  def delete_activity(%Activity{} = activity) do
    Repo.delete(activity)
  end

  def change_activity(%Activity{} = activity, attrs \\ %{}) do
    Activity.changeset(activity, attrs)
  end
end
