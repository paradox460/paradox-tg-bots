defmodule TgBotsWeb.Router do
  use TgBotsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TgBotsWeb do
    pipe_through :api

    # get "/", PageController, :index
    post "/spurdify/prFnGNeVE35Tg/VORNI+QNIW0aJjj+RxVoXfM+V7E2R4CaNi3HS0KQW9WKF5JWm7/", SpurdifyController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", TgBotsWeb do
  #   pipe_through :api
  # end
end
