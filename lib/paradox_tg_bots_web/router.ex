defmodule ParadoxTgBotsWeb.Router do
  use ParadoxTgBotsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ParadoxTgBotsWeb.Plugs.Auth
  end

  scope "/", ParadoxTgBotsWeb do
    pipe_through :api

    post "/spurdify", SpurdifyController, :create
  end
end
