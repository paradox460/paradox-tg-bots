defmodule ParadoxTgBotsWeb.Plugs.Auth do
  import Plug.Conn

  def init(_), do: nil

  def call(conn, _opts) do
    local_token = Application.get_env(:paradox_tg_bots, :config)[:webhook_secret]
    [received_token] = get_req_header(conn, "x-telegram-bot-api-secret-token")

    if local_token == received_token do
      conn
    else
      conn
      |> send_resp(403, "")
      |> halt
    end
  end
end
