defmodule PhxchatWeb.PageLive do
  use PhxchatWeb, :live_view
  alias PhxchatWeb.PageView
  require Logger

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(query: "", results: %{})}
  end

  def render(assigns) do
    PageView.render("index.html", assigns)
  end

  def handle_event("random-room", _params, socket) do
    random_slug = "/" <> MnemonicSlugs.generate_slug(4)
    Logger.info("Generate a random room: #{random_slug}")
    {:noreply, push_redirect(socket, to: random_slug)}
  end
end
