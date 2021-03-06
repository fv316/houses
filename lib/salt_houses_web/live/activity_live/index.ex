defmodule SaltHousesWeb.ActivityLive.Index do
  use SaltHousesWeb, :live_view

  alias SaltHouses.House
  alias SaltHouses.Houses.Schemas.Activity

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :activities, list_activities())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Activity")
    |> assign(:activity, House.get_activity!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Activity")
    |> assign(:activity, %Activity{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Activities")
    |> assign(:activity, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    activity = House.get_activity!(id)
    {:ok, _} = House.delete_activity(activity)

    {:noreply, assign(socket, :activities, list_activities())}
  end

  defp list_activities do
    House.list_activities()
  end
end
