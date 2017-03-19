defmodule Dailies.PageController do
  use Dailies.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
