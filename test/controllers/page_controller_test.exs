defmodule Dailies.PageControllerTest do
  use Dailies.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "You like my dailies"
  end
end
