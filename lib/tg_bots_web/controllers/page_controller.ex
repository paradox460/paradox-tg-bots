defmodule TgBotsWeb.PageController do
  use TgBotsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
