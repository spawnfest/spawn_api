defmodule SpawnApi.SpawnTest do
  use SpawnApi.DataCase

  alias SpawnApi.Spawn

  describe "api_datas" do
    alias SpawnApi.Spawn.ApiData

    @valid_attrs %{data: %{}}
    @update_attrs %{data: %{}}
    @invalid_attrs %{data: nil}

    def api_data_fixture(attrs \\ %{}) do
      {:ok, api_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Spawn.create_api_data()

      api_data
    end

    test "list_api_datas/0 returns all api_datas" do
      api_data = api_data_fixture()
      assert Spawn.list_api_datas() == [api_data]
    end

    test "get_api_data!/1 returns the api_data with given id" do
      api_data = api_data_fixture()
      assert Spawn.get_api_data!(api_data.id) == api_data
    end

    test "create_api_data/1 with valid data creates a api_data" do
      assert {:ok, %ApiData{} = api_data} = Spawn.create_api_data(@valid_attrs)
      assert api_data.data == %{}
    end

    test "create_api_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spawn.create_api_data(@invalid_attrs)
    end

    test "update_api_data/2 with valid data updates the api_data" do
      api_data = api_data_fixture()
      assert {:ok, %ApiData{} = api_data} = Spawn.update_api_data(api_data, @update_attrs)
      assert api_data.data == %{}
    end

    test "update_api_data/2 with invalid data returns error changeset" do
      api_data = api_data_fixture()
      assert {:error, %Ecto.Changeset{}} = Spawn.update_api_data(api_data, @invalid_attrs)
      assert api_data == Spawn.get_api_data!(api_data.id)
    end

    test "delete_api_data/1 deletes the api_data" do
      api_data = api_data_fixture()
      assert {:ok, %ApiData{}} = Spawn.delete_api_data(api_data)
      assert_raise Ecto.NoResultsError, fn -> Spawn.get_api_data!(api_data.id) end
    end

    test "change_api_data/1 returns a api_data changeset" do
      api_data = api_data_fixture()
      assert %Ecto.Changeset{} = Spawn.change_api_data(api_data)
    end
  end
end
