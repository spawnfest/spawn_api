defmodule SpawnApiWeb.ApiDataController do
  use SpawnApiWeb, :controller

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiData

  action_fallback SpawnApiWeb.FallbackController

  def index(conn, _params) do
    api_datas = Spawn.list_api_datas()
    render(conn, "index.json", api_datas: api_datas)
  end

  def create(conn, %{"api_data" => api_data_params}) do
    with {:ok, %ApiData{} = api_data} <- Spawn.create_api_data(api_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_data_path(conn, :show, api_data))
      |> render("show.json", api_data: api_data)
    end
  end

  def show(conn, %{"id" => id}) do
    api_data = Spawn.get_api_data!(id)
    render(conn, "show.json", api_data: api_data)
  end

  def update(conn, %{"id" => id, "api_data" => api_data_params}) do
    api_data = Spawn.get_api_data!(id)

    with {:ok, %ApiData{} = api_data} <- Spawn.update_api_data(api_data, api_data_params) do
      render(conn, "show.json", api_data: api_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    api_data = Spawn.get_api_data!(id)

    with {:ok, %ApiData{}} <- Spawn.delete_api_data(api_data) do
      send_resp(conn, :no_content, "")
    end
  end
end
