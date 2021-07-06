defmodule SaltHousesWeb.HouseLive.Index do
  use SaltHousesWeb, :live_view

  alias SaltHouses.House

  def mount(_params, _, socket) do
    House.subscribe()
    {:ok, fetch(socket)}
  end

  def handle_event(
        "complete",
        %{"completed_activity" => %{"member_id" => mid, "activity_id" => aid}},
        socket
      ) do
    House.complete_activity(mid, aid)
    {:noreply, socket}
  end

  def handle_info({SaltHouses.House, [:comleted_activity | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    house_points = House.get_house_points()
    member_points = House.get_member_points()
    activities = House.get_activities()
    members = House.get_members()
    assign(socket, %{house_points: house_points, member_points: member_points, activities: activities, members: members})
  end
end
