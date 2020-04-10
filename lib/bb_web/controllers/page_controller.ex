defmodule BBWeb.PageController do
  use BBWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
