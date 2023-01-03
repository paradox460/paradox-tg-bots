defmodule ParadoxTgBotsWeb.Router do
  use ParadoxTgBotsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ParadoxTgBotsWeb do
    pipe_through :api
  end
end
