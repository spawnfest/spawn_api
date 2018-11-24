defmodule SpawnApi.SpawnTest do
  use SpawnApi.DataCase

  alias SpawnApi.Spawn

  describe "api_schemas" do
    alias SpawnApi.Spawn.ApiSchema

    @valid_attrs %{data: %{}}
    @valid_nested_attrs %{data: %{test: "test", nested: %{nested_test: "test"}}}
    @update_attrs %{data: %{}}
    @invalid_attrs %{data: nil}

    def api_schema_fixture(attrs \\ %{}) do
      {:ok, api_schema} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Spawn.create_api_schema()

      api_schema
    end

    test "list_api_schemas/0 returns all api_schemas" do
      api_schema = api_schema_fixture()
      assert Spawn.list_api_schemas() == [api_schema]
    end

    test "get_api_schema!/1 returns the api_schema with given id" do
      api_schema = api_schema_fixture()
      assert Spawn.get_api_schema!(api_schema.id) == api_schema
    end

    test "create_api_schema/1 with valid data creates a api_schema" do
      assert {:ok, %ApiSchema{} = api_schema} = Spawn.create_api_schema(@valid_attrs)
      assert api_schema.data == %{}
    end

    test "create_api_schema/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spawn.create_api_schema(@invalid_attrs)
    end

    test "create_api_schema/1 with valid nested data creates an api_schema" do
      assert {:ok, %ApiSchema{} = api_schema} = Spawn.create_api_schema(@valid_nested_attrs)
      assert api_schema.data == %{test: "test", nested: %{nested_test: "test"}}
    end

    test "update_api_schema/2 with valid data updates the api_schema" do
      api_schema = api_schema_fixture()
      assert {:ok, %ApiSchema{} = api_schema} = Spawn.update_api_schema(api_schema, @update_attrs)
      assert api_schema.data == %{}
    end

    test "update_api_schema/2 with invalid data returns error changeset" do
      api_schema = api_schema_fixture()
      assert {:error, %Ecto.Changeset{}} = Spawn.update_api_schema(api_schema, @invalid_attrs)
      assert api_schema == Spawn.get_api_schema!(api_schema.id)
    end

    test "delete_api_schema/1 deletes the api_schema" do
      api_schema = api_schema_fixture()
      assert {:ok, %ApiSchema{}} = Spawn.delete_api_schema(api_schema)
      assert_raise Ecto.NoResultsError, fn -> Spawn.get_api_schema!(api_schema.id) end
    end

    test "change_api_schema/1 returns a api_schema changeset" do
      api_schema = api_schema_fixture()
      assert %Ecto.Changeset{} = Spawn.change_api_schema(api_schema)
    end
  end
end
