defmodule SaltHousesWeb.HouseLive do
  use SaltHousesWeb, :live_view

  alias SaltHouses.House

  def render(assigns) do
    ~L"""
    <h1>Leader Board</h1>
    Current points: <%= @points %>
    <br>
    <button phx-click="increment">+</button>
    <button phx-click="decrement">-</button>
    """
  end

  def mount(_params, _, socket) do
    points = House.get_points()
    {:ok, assign(socket, :points, points)}
  end

  def handle_event("increment", _, socket),
    do: {:noreply, assign(socket, :points, socket.assigns.points + 1)}

  def handle_event("decrement", _, socket),
    do: {:noreply, assign(socket, :points, socket.assigns.points - 1)}
end
