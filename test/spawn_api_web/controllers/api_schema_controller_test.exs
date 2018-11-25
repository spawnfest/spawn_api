defmodule SpawnApiWeb.ApiSchemaControllerTest do
  use SpawnApiWeb.ConnCase

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiSchema

  @create_attrs %{
    schema: %{
      emails: "email"
    }
  }
  @create_nested_attrs %{
    schema: %{
      test: "test",
      nested: %{nested_test: "test"}
    }
  }
  @update_attrs %{
    schema: %{}
  }

  def fixture(:api_schema) do
    {:ok, api_schema} = Spawn.create_api_schema(@create_attrs)
    api_schema
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all api_schemas", %{conn: conn} do
      conn = get(conn, Routes.api_schema_path(conn, :index))
      assert json_response(conn, 200)["schema"] == []
    end
  end

  describe "create api_schema" do
    test "renders api_schema when schema is valid", %{conn: conn} do
      conn = post(conn, Routes.api_schema_path(conn, :create), schema: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["schema"]

      conn = get(conn, Routes.api_schema_path(conn, :show, id))

      assert %{
               "id" => id,
               "schema" => %{}
             } = json_response(conn, 200)["schema"]
    end

    test "renders api_schema when nested schema is valid", %{conn: conn} do
      conn = post(conn, Routes.api_schema_path(conn, :create), schema: @create_nested_attrs)
      assert %{"id" => id} = json_response(conn, 201)["schema"]

      conn = get(conn, Routes.api_schema_path(conn, :show, id))

      assert %{
               "id" => id,
               "schema" => %{
                 "schema" => %{
                   "test" => "test",
                   "nested" => %{"nested_test" => "test"}
                 }
               }
             } = json_response(conn, 200)["schema"]
    end

    test "renders errors when schema is not a parameter", %{conn: conn} do
      conn = post(conn, Routes.api_schema_path(conn, :create))
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update api_schema" do
    setup [:create_api_schema]

    test "renders api_schema when schema is valid", %{
      conn: conn,
      schema: %ApiSchema{id: id} = api_schema
    } do
      conn = put(conn, Routes.api_schema_path(conn, :update, api_schema), schema: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["schema"]

      conn = get(conn, Routes.api_schema_path(conn, :show, id))

      assert %{
               "id" => id,
               "schema" => %{}
             } = json_response(conn, 200)["schema"]
    end

    test "renders errors when schema is not a parameter", %{conn: conn, schema: api_schema} do
      conn = put(conn, Routes.api_schema_path(conn, :update, api_schema))

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "generate api_schema" do
    setup [:create_api_schema]

    test "generates 10 rows of chosen api_schema", %{
      conn: conn,
      schema: %ApiSchema{id: id} = api_schema
    } do
      conn = get(conn, Routes.api_schema_path(conn, :generate, api_schema))
      json = json_response(conn, 200)
      assert %{"id" => ^id} = json["schema"]
      assert json["data"] |> Map.get("emails") |> length() == 10
    end
  end

  describe "delete api_schema" do
    setup [:create_api_schema]

    test "deletes chosen api_schema", %{conn: conn, schema: api_schema} do
      conn = delete(conn, Routes.api_schema_path(conn, :delete, api_schema))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_schema_path(conn, :show, api_schema))
      end
    end
  end

  defp create_api_schema(_) do
    api_schema = fixture(:api_schema)
    {:ok, schema: api_schema}
  end
end
