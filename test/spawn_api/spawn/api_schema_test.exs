defmodule SpawnApi.ApiSchemaTest do
  use SpawnApi.DataCase

  alias SpawnApi.Spawn
  alias SpawnApi.Spawn.ApiSchema

  describe "generate_data" do
    @valid_attrs %{schema: %{"emails" => "email"}}

    def api_schema_fixture(attrs \\ %{}) do
      {:ok, api_schema} =
        attrs
        |> Spawn.create_api_schema()

      api_schema
    end

    test "generate_data should return a map containing emails" do
      email =
        api_schema_fixture(@valid_attrs)
        |> ApiSchema.generate_data(%{}, 1)
        |> Map.get("emails")

      assert email |> Enum.at(0) |> String.contains?("@") == true
    end

    test "generate should return 10 rows of emails" do
      emails =
        api_schema_fixture(@valid_attrs)
        |> ApiSchema.generate_data(%{}, 10)
        |> Map.get("emails")

      assert length(emails) == 10
    end
  end

  test "generate data should return an empty map when given a non-positive integer" do
    data =
      api_schema_fixture(@valid_attrs)
      |> ApiSchema.generate_data(%{}, 0)

    assert data == %{}
  end
end
