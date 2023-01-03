defmodule ParadoxTgBotsWeb.SpurdifyController do
  use ParadoxTgBotsWeb, :controller
  import ParadoxTgBots.Spurdify, only: [spurdify: 1]

  # Inline queries
  def create(conn, %{"inline_query" => %{"query" => q, "id" => id}}) do
    render(conn, "inline_query.json", text: spurdify(q), id: id)
  end

  # Message
  def create(conn, %{
        "message" => %{"text" => text, "chat" => %{"id" => chat_id, "type" => "private"}}
      }) do
    cond do
      text =~ ~r{\A/help}i -> render(conn, "help_response.json", chat_id: chat_id)
      text =~ ~r{\A/start}i -> render(conn, "start_response.json", chat_id: chat_id)
      true -> render(conn, "message_response.json", text: spurdify(text), chat_id: chat_id)
    end
  end

  # Bot command
  def create(conn, %{
        "message" => %{"text" => text, "message_id" => message_id, "chat" => %{"id" => chat_id}}
      }) do
    if text =~ ~r{\A/spurdify(?:@.*?)?\s+.+}i do
      text
      |> String.replace(~r{\A/spurdify(?:@.*?)?\s+}i, "")
      |> spurdify()
      |> then(
        &render(conn, "message_response.json", text: &1, chat_id: chat_id, message_id: message_id)
      )
    else
      send_resp(conn, 204, "")
    end
  end

  def create(conn, _params), do: send_resp(conn, 204, "")
end
