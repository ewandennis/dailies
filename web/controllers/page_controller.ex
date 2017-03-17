defmodule Giflator.PageController do
  use Giflator.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
