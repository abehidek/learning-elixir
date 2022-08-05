defmodule PhxchatWeb.RoomLive do
  use PhxchatWeb, :live_view
  require Logger

  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    username = MnemonicSlugs.generate_slug(2)

    if connected?(socket) do
      PhxchatWeb.Endpoint.subscribe(topic)
      PhxchatWeb.Presence.track(self(), topic, username, %{})
    end

    {:ok,
     socket
     |> assign(
       room_id: room_id,
       message: "",
       username: username,
       topic: topic,
       messages: [],
       user_list: [],
       temporary_assigns: [messages: []]
     )}
  end

  def handle_event("submit_message", %{"chat" => %{"message" => message}}, socket) do
    message = %{uuid: UUID.uuid4(), content: message, username: socket.assigns.username}
    Logger.info("Message submited: #{message.content}")
    PhxchatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message", message)
    {:noreply, socket |> assign(message: "")}
  end

  def handle_event("form_update", %{"chat" => %{"message" => message}}, socket) do
    Logger.info(message: message)
    {:noreply, socket |> assign(message: message)}
  end

  def handle_info(%{event: "new-message", payload: message}, socket) do
    Logger.info(payload: message)
    {:noreply, assign(socket, messages: [message])}
  end

  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    Logger.info(joins: joins, leaves: leaves)

    join_messages =
      joins
      |> Map.keys()
      |> Enum.map(fn username ->
        %{type: :system, uuid: UUID.uuid4(), content: "#{username} joined"}
      end)

    leave_messages =
      leaves
      |> Map.keys()
      |> Enum.map(fn username ->
        %{type: :system, uuid: UUID.uuid4(), content: "#{username} left"}
      end)

    user_list =
      PhxchatWeb.Presence.list(socket.assigns.topic)
      |> Map.keys()

    Logger.info(user_list: user_list)

    {:noreply, socket |> assign(messages: join_messages ++ leave_messages, user_list: user_list)}
  end

  def display_message(assigns, %{type: :system, uuid: uuid, content: content}) do
    ~H"""
      <p id={uuid}> <em> <%= content %></em></p>
    """
  end

  def display_message(assigns, %{username: username, uuid: uuid, content: content}) do
    ~H"""
      <p id={uuid}> <strong> <%= username %>: </strong> <%= content %></p>
    """
  end
end
