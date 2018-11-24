defmodule SpawnApiWeb.ApiSchemaView do
  use SpawnApiWeb, :view
  alias SpawnApiWeb.ApiSchemaView

  def render("index.json", %{schemas: api_schemas}) do
    %{schema: render_many(api_schemas, ApiSchemaView, "api_schema.json")}
  end

  def render("show.json", %{schema: api_schema}) do
    %{schema: render_one(api_schema, ApiSchemaView, "api_schema.json")}
  end

  def render("api_schema.json", %{schema: api_schema}) do
    %{id: api_schema.id, schema: api_schema.schema}
  end
end
