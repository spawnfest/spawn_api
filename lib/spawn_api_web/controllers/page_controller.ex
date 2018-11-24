defmodule SpawnApiWeb.PageController do
  use SpawnApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
