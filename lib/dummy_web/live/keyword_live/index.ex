defmodule DummyWeb.KeywordLive.Index do
  use DummyWeb, :live_view

  alias Dummy.Huiyoucai
  alias Dummy.Huiyoucai.Keyword

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :keywords, list_keywords())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.inspect("##########")
    IO.inspect(params, label: "params")
    IO.inspect(socket, label: "socket")

    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Keyword")
    |> assign(:keyword, Huiyoucai.get_keyword!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Keyword")
    |> assign(:keyword, %Keyword{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Keywords")
    |> assign(:keyword, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    keyword = Huiyoucai.get_keyword!(id)
    {:ok, _} = Huiyoucai.delete_keyword(keyword)

    {:noreply, assign(socket, :keywords, list_keywords())}
  end

  @impl true
  def handle_event("change_state", attrs, socket) do
    %{"id" => id} = attrs
    IO.inspect(attrs, label: "change-state")

    {:ok, _} = Huiyoucai.keyword_change_state(id)

    {:noreply, assign(socket, :keywords, list_keywords())}
  end

  defp list_keywords do
    Huiyoucai.list_keywords()
  end
end
