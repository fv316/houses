defmodule SaltHouses.House.Data do
  import Ecto.{Changeset, Query}

  alias SaltHouses.Repo
  alias SaltHouses.House.Schemas.{Activity, CompletedActivity, House, Member}

  def get_activity(id) do
    case Activity |> where([i], i.id == ^id) |> Repo.one() do
      nil -> {:error, :none}
      record -> {:ok, record}
    end
  end

  def get_all_activities() do
    case Activity |> Repo.all() do
      [] -> {:error, :none}
      records -> {:ok, records}
    end
  end

  def create_activity(payload) do
    payload
    |> Activity.insert_changeset()
    |> Repo.insert()
  end

  def update_activity(activity, payload) do
    activity
    |> change(payload)
    |> Repo.update()
  end

  def create_completed_activity(payload) do
    payload
    |> CompletedActivity.insert_changeset()
    |> Repo.insert()
  end

  def get_house(id) do
    case House |> where([i], i.id == ^id) |> Repo.one() do
      nil -> {:error, :none}
      record -> {:ok, record}
    end
  end

  def get_all_houses() do
    case House |> Repo.all() do
      [] -> {:error, :none}
      records -> {:ok, records}
    end
  end

  def get_member(id) do
    case Member |> where([i], i.id == ^id) |> Repo.one() do
      nil -> {:error, :none}
      record -> {:ok, record}
    end
  end

  def get_all_members() do
    case Member |> Repo.all() do
      [] -> {:error, :none}
      records -> {:ok, records}
    end
  end

  def create_member(payload) do
    payload
    |> Member.insert_changeset()
    |> Repo.insert()
  end

  def update_member(member, payload) do
    member
    |> change(payload)
    |> Repo.update()
  end

  def get_house_points do
    CompletedActivity
    |> join(:inner, [c], a in Activity, on: c.activity_id == a.id)
    |> join(:inner, [c, a], m in Member, on: c.member_id == m.id)
    |> join(:inner, [c, a, m], h in House, on: m.house_id == h.id)
    |> group_by([c, a, m, h], h.name)
    |> select([c, a, m, h], %{name: h.name, points: sum(a.points)})
    |> order_by([c, a, m, h], [desc: sum(a.points)])
    |> Repo.all()
  end

  def get_member_points do
    CompletedActivity
    |> join(:inner, [c], a in Activity, on: c.activity_id == a.id)
    |> join(:inner, [c, a], m in Member, on: c.member_id == m.id)
    |> group_by([c, a, m], m.name)
    |> select([c, a, m], %{name: m.name, points: sum(a.points)})
    |> order_by([c, a, m], [desc: sum(a.points)])
    |> Repo.all()
  end
end
