defmodule SpawnApiWeb.ApiSchemaController do
  use SpawnApiWeb, :controller

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiSchema
  alias SpawnApi.Utils.CSV, as: CSVUtils

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
    with {:ok, api_schema} <- Spawn.get_api_schema(id) do
      conn
      |> render("show.json", api_schema: api_schema)
    end
  end

  def generate(conn, %{"id" => id, "rows" => rows} = params) do
    with {:ok, api_schema} <- Spawn.get_api_schema(id),
         {:ok, num_rows} <- SpawnApi.Utils.parse_integer(rows) do
      data = ApiSchema.generate_data(api_schema, %{}, num_rows)

      conn
      |> render("generated_data.json", %{schema: api_schema, data: data})
    end
  end

  def export_csv(conn, %{"id" => id, "rows" => rows} = params) do
    with {:ok, api_schema} <- Spawn.get_api_schema(id),
         {:ok, num_rows} <- SpawnApi.Utils.parse_integer(rows) do
      data = ApiSchema.generate_data(api_schema, %{}, num_rows)
      render_file = String.to_existing_atom(Map.get(params, "file", "false"))

      csv_data = CSVUtils.transpose_generated_data(data)

      conn
      |> put_download_header(params, render_file)
      |> send_resp(200, csv_data)
    end
  end

  def generate(conn, %{"id" => id}) do
    with {:ok, api_schema} <- Spawn.get_api_schema(id) do
      data = ApiSchema.generate_data(api_schema, %{}, 10)

      conn
      |> render("generated_data.json", %{schema: api_schema, data: data})
    end
  end

  def update(conn, %{"id" => id, "schema" => schema_params}) do
    with {:ok, api_schema} <- Spawn.get_api_schema(id),
         {:ok, %ApiSchema{} = api_schema} <- Spawn.update_api_schema(api_schema, schema_params) do
      conn
      |> render("show.json", api_schema: api_schema)
    end
  end

  def update(_conn, _),
    do: {:error, :unprocessable_entity, %{message: "Missing schema or id parameter"}}

  def delete(conn, %{"id" => id}) do
    with {:ok, api_schema} <- Spawn.get_api_schema(id),
         {:ok, %ApiSchema{}} <- Spawn.delete_api_schema(api_schema) do
      send_resp(conn, :no_content, "")
    end
  end

  defp put_download_header(conn, params, true) do
    filename = Map.get(params, "filename", "data")
    extension = Map.get(params, "format", "csv")

    put_resp_header(
      conn,
      "Content-Disposition",
      "attachment; filename=\"#{filename}.#{extension}\""
    )
  end

  defp put_download_header(conn, _params, false), do: conn
end
