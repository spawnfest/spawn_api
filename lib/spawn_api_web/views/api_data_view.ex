defmodule SpawnApiWeb.ApiDataView do
  use SpawnApiWeb, :view
  alias SpawnApiWeb.ApiDataView

  def render("index.json", %{api_datas: api_datas}) do
    %{data: render_many(api_datas, ApiDataView, "api_data.json")}
  end

  def render("show.json", %{api_data: api_data}) do
    %{data: render_one(api_data, ApiDataView, "api_data.json")}
  end

  def render("api_data.json", %{api_data: api_data}) do
    %{id: api_data.id, data: api_data.data}
  end
end
