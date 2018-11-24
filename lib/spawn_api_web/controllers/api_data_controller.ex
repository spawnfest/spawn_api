defmodule SpawnApiWeb.ApiDataController do
  use SpawnApiWeb, :controller

  action_fallback SpawnApiWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.html")
  end

  #  def show(conn, %{"id" => id}) do
  #    data = ApiData.get_data(id)
  #    render(conn, "show.json", data: data)
  #  end

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
