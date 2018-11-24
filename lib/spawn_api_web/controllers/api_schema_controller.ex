defmodule SpawnApiWeb.ApiSchemaController do
  use SpawnApiWeb, :controller

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiSchema

  action_fallback SpawnApiWeb.FallbackController

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def index(conn, _params) do
    api_schemas = Spawn.list_api_schemas()
    render(conn, "index.json", api_schemas: api_schemas)
  end

  def create(conn, %{"schema" => _schema} = schema_params) do
    with {:ok, %ApiSchema{} = api_schema} <- Spawn.create_api_schema(schema_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_schema_path(conn, :show, api_schema))
      |> render("show.json", api_schema: api_schema)
    end
  end

  def create(_conn, _),
    do: {:error, :unprocessable_entity, %{message: "Missing schema parameter"}}

  def show(conn, %{"id" => id}) do
    api_schema = Spawn.get_api_schema!(id)
    render(conn, "show.json", api_schema: api_schema)
  end

  def generate(conn, %{"id" => id, "rows" => rows}) do
    api_schema = Spawn.get_api_schema!(id)
    data = ApiSchema.generate(api_schema, String.to_integer(rows) || 10)
    render(conn, "generated_data.json", %{schema: api_schema, data: data})
  end

  def generate(conn, %{"id" => id}) do
    api_schema = Spawn.get_api_schema!(id)
    data = ApiSchema.generate(api_schema, 10)
    render(conn, "generated_data.json", %{schema: api_schema, data: data})
  end

  def update(conn, %{"id" => id, "schema" => schema_params}) do
    api_schema = Spawn.get_api_schema!(id)

    with {:ok, %ApiSchema{} = api_schema} <- Spawn.update_api_schema(api_schema, schema_params) do
      render(conn, "show.json", api_schema: api_schema)
    end
  end

  def update(_conn, _),
    do: {:error, :unprocessable_entity, %{message: "Missing schema or id parameter"}}

  def delete(conn, %{"id" => id}) do
    api_schema = Spawn.get_api_schema!(id)

    with {:ok, %ApiSchema{}} <- Spawn.delete_api_schema(api_schema) do
      send_resp(conn, :no_content, "")
    end
  end
end
