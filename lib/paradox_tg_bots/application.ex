defmodule ParadoxTgBots.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ParadoxTgBotsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ParadoxTgBots.PubSub},
      # Start the Endpoint (http/https)
      ParadoxTgBotsWeb.Endpoint,
      {Finch, name: Finch},
      ParadoxTgBots.WebhookRegister
      # Start a worker by calling: ParadoxTgBots.Worker.start_link(arg)
      # {ParadoxTgBots.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ParadoxTgBots.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ParadoxTgBotsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
