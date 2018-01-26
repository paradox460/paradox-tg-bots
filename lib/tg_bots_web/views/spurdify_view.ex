defmodule TgBotsWeb.SpurdifyView do
  use TgBotsWeb, :view

  def render("inline-query.json", %{text: text, id: id}) do
    %{
      "method" => "answerInlineQuery",
      "inline_query_id" => id,
      "next_offset" => "",
      "results" => [
        %{
          "type" => "article",
          "id" => Base.encode16(:crypto.hash(:sha256, text)),
          "title" => "Spurdified Text",
          "input_message_content" => %{
            "message_text" => text
          },
          "description" => text,
          "thumb_url" => static_url(TgBotsWeb.Endpoint, "/images/spurdo.png")
        }
      ]
    }
  end

  def render("message-response.json", %{text: text, chat_id: chat_id} = assigns) do
    %{message_id: message_id} = Map.merge(%{message_id: ""}, assigns)

    %{
      "method"              => "sendMessage",
      "chat_id"             => chat_id,
      "text"                => text,
      "reply_to_message_id" => message_id
    }
  end

  def render("help-response.json", %{chat_id: chat_id}) do
    %{
      "method"               => "sendMessage",
      "chat_id"              => chat_id,
      "disable_notification" => true,
      "text"                 => ~s"""
      Hello there, I'm a bot that can spurdify text and make it look like this: `oh fugg hi dere :DDD

      I will respond to any message you send me in private, and in channels I respond to the /spurdify command.
      """
    }
  end

  def render("start-response.json", %{chat_id: chat_id}) do
    %{
      "method"               => "sendMessage",
      "chat_id"              => chat_id,
      "disable_notification" => true,
      "text"                 => ~s"""
      oh fugg you activated spurdo :DDDDDDDDDDDD

      (use the /spurdify slash command in groups, i spurdify everything in here)
      """
    }
  end
end
