defmodule SaltHousesWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias SaltHouses.Accounts

  @doc """
  Renders a component inside the `SaltHousesWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, SaltHousesWeb.ActivityLive.FormComponent,
        id: @user.id || :new,
        action: @live_action,
        user: @user,
        return_to: Routes.activity_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(SaltHousesWeb.ModalComponent, modal_opts)
  end

  def assign_defaults(%{"user_id" => user_id}, socket) do
    socket = assign_new(socket, :current_user, fn -> Accounts.get_user!(user_id) end)

    if socket.assigns.current_user.confirmed_at do
      socket
    else
      redirect(socket, to: "/login")
    end
  end
end
