defmodule TgBotsWeb.SpurdifyController do
  use TgBotsWeb, :controller
  import TgBots.Spurdify, only: [spurdify: 1]

  # Inline Query
  def create(conn, %{"inline_query" => %{"query" => q, "id" => id }} = params) do
    render(conn, "inline-query.json", text: spurdify(q), id: id )
  end
  # Message
  def create(conn, %{"message" => %{"text" => text, "chat" => %{"id" => chat_id, "type" => "private"}}}) do
    cond do
      text =~ ~r{\A/help}i -> render(conn, "help-response.json", chat_id: chat_id)
      text =~ ~r{\A/start}i -> render(conn, "start-response.json", chat_id: chat_id)
      true -> render(conn, "message-response.json", text: spurdify(text), chat_id: chat_id)
    end
  end
  # Bot command
  def create(conn, %{"message" => %{"text" => text, "message_id" => message_id, "chat" => %{"id" => chat_id}}} = params) do
    if text =~ ~r{\A/spurdify(?:@.*?)?\s+.+}i do
      text = String.replace(text, ~r{\A/spurdify(?:@.*?)?\s+}i,"")
      render(conn, "message-response.json", text: spurdify(text), chat_id: chat_id, message_id: message_id)
    else
      send_resp(conn, 204, "")
    end
  end

  def create(conn, params) do
    conn |> send_resp(204, "")
  end
end
