defmodule DummyWeb.KeywordLive.Show do
  use DummyWeb, :live_view

  alias Dummy.Huiyoucai

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:keyword, Huiyoucai.get_keyword!(id))}
  end

  defp page_title(:show), do: "Show Keyword"
  defp page_title(:edit), do: "Edit Keyword"
end
