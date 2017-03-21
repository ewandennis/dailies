defmodule Dailies.RelayWebhookController do
  use Dailies.Web, :controller

  alias Dailies.Slide

  def post(conn, %{"_json" => batch}) do
    Enum.each(batch, fn msg -> process_msg(msg) end) 
    json(conn, %{:ok => true})
  end

  def process_msg(%{"msys" => %{"relay_message" => msg}}) do
    url = url_from_msg(msg)
    if url do
      changeset = Slide.changeset(%Slide{}, %{:url=>url})
      Repo.insert(changeset)
    end
  end

  def url_from_msg(msg) do
    content = msg["content"]
    subjecturl = extract_first_url(content["subject"])
    if not is_nil(subjecturl) do
      subjecturl
    else
      extract_first_url(content["html"])
    end
  end

  def extract_first_url(txt) when is_binary(txt) do
    match = Regex.run(~r/(https?:\/\/[\d\w-]+(?:\.[\d\w-]+)*(?:\/[^\s]*)?)/, txt)
    case match do
      captures when not is_nil(match) -> hd(tl(captures))
      _ -> nil
    end
  end
end

