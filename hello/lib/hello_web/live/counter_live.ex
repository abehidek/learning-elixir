defmodule HelloWeb.CounterLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :number, 0)}
  end

  def render(assigns) do
    ~L"""
    <section>
      <p class="text-4xl font-bold underline">Counter</p>
      <p>Count: <%= @number %></p>
      <button phx-click="inc">+</button>
      <button phx-click="dec">-</button>
    </section>
    """
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :number, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :number, &(&1 - 1))}
  end
end
