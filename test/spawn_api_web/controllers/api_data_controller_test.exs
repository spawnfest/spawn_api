defmodule SpawnApiWeb.ApiDataControllerTest do
  use SpawnApiWeb.ConnCase

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiData

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

  def fixture(:api_data) do
    {:ok, api_data} = Spawn.create_api_data(@create_attrs)
    api_data
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all api_datas", %{conn: conn} do
      conn = get(conn, Routes.api_data_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create api_data" do
    test "renders api_data when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_data_path(conn, :create), api_data: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_data_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders api_data when nested data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_data_path(conn, :create), api_data: @create_nested_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_data_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => %{
                 "test" => "test",
                 "nested" => %{"nested_test" => "test"}
               }
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_data_path(conn, :create), api_data: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update api_data" do
    setup [:create_api_data]

    test "renders api_data when data is valid", %{
      conn: conn,
      api_data: %ApiData{id: id} = api_data
    } do
      conn = put(conn, Routes.api_data_path(conn, :update, api_data), api_data: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_data_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, api_data: api_data} do
      conn = put(conn, Routes.api_data_path(conn, :update, api_data), api_data: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete api_data" do
    setup [:create_api_data]

    test "deletes chosen api_data", %{conn: conn, api_data: api_data} do
      conn = delete(conn, Routes.api_data_path(conn, :delete, api_data))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_data_path(conn, :show, api_data))
      end
    end
  end

  defp create_api_data(_) do
    api_data = fixture(:api_data)
    {:ok, api_data: api_data}
  end
end
