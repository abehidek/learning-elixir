defmodule HelloWeb.CounterLive do
  use Phoenix.LiveView
  alias HelloWeb.CounterView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:number, 0)}
  end

  def render(assigns) do
    CounterView.render("counter.html", assigns)
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :number, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :number, &(&1 - 1))}
  end
end
