defmodule SaltHousesWeb.HouseLive.Index do
  use SaltHousesWeb, :live_view

  alias SaltHouses.House

  def mount(_params, _, socket) do
    House.subscribe()
    {:ok, fetch(socket)}
  end

  def handle_info({SaltHouses.House, [:comleted_activity | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    house_points = House.get_house_points()
    assign(socket, %{house_points: house_points})
  end
end
