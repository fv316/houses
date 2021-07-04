defmodule SaltHousesWeb.HouseLive do
  use SaltHousesWeb, :live_view

  alias SaltHouses.House

  # def render(assigns) do
  #   IO.inspect(assigns)
  #   ~L"""
  #   <h1>Leader Board</h1>
  #   Current points: <%= @points %>
  #   <br>
  #   <button phx-click="increment">+</button>
  #   <button phx-click="decrement">-</button>
  #   """
  # end

  def mount(_params, _, socket) do
    House.subscribe()
    {:ok, fetch(socket)}
  end

  def handle_event("complete", %{"completed_activity" => %{"member_id" => mid, "activity_id" => aid}}, socket) do
    House.complete_activity(mid, aid)
    {:noreply, socket}
  end

  def handle_info({SaltHouses.House, [:comleted_activity | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    points = House.get_points()
    activities = House.get_activities()
    members = House.get_members()
    assign(socket, %{houses: points, activities: activities, members: members})
  end
end
