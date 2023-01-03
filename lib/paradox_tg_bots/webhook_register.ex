defmodule ParadoxTgBots.WebhookRegister do
  use Task

  def start_link(_arg), do: Task.start_link(__MODULE__, :run, [])

  def run() do
    IO.puts("Webhook registration")
    token = Application.get_env(:paradox_tg_bots, :config)[:tg_token]
    secret = Application.get_env(:paradox_tg_bots, :config)[:webhook_secret]

    Finch.build(
      :post,
      "https://api.telegram.org/bot#{token}/setWebhook",
      [],
      Jason.encode!(%{
        url: "localhost",
        allowed_updates: ~w[message inline_query],
        drop_pending_updates: true,
        secret_token: secret
      })
    )
    |> Finch.request(Finch)

    IO.puts("Webhook registration completed")
  end
end
