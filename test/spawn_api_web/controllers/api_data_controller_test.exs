defmodule SpawnApiWeb.ApiSchemaControllerTest do
  use SpawnApiWeb.ConnCase

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiSchema

  @create_attrs %{
    data: %{}
  }
  @create_nested_attrs %{
    data: %{
      test: "test",
      nested: %{nested_test: "test"}
    }
  }
  @update_attrs %{
    data: %{}
  }
  @invalid_attrs %{data: nil}

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
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create api_schema" do
    test "renders api_schema when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_schema_path(conn, :create), api_schema: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_schema_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders api_schema when nested data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_schema_path(conn, :create), api_schema: @create_nested_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_schema_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => %{
                 "test" => "test",
                 "nested" => %{"nested_test" => "test"}
               }
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_schema_path(conn, :create), api_schema: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update api_schema" do
    setup [:create_api_schema]

    test "renders api_schema when data is valid", %{
      conn: conn,
      api_schema: %ApiSchema{id: id} = api_schema
    } do
      conn =
        put(conn, Routes.api_schema_path(conn, :update, api_schema), api_schema: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_schema_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, api_schema: api_schema} do
      conn =
        put(conn, Routes.api_schema_path(conn, :update, api_schema), api_schema: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete api_schema" do
    setup [:create_api_schema]

    test "deletes chosen api_schema", %{conn: conn, api_schema: api_schema} do
      conn = delete(conn, Routes.api_schema_path(conn, :delete, api_schema))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_schema_path(conn, :show, api_schema))
      end
    end
  end

  defp create_api_schema(_) do
    api_schema = fixture(:api_schema)
    {:ok, api_schema: api_schema}
  end
end
