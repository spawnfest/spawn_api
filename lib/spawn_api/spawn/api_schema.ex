defmodule SpawnApi.Spawn.ApiSchema do
  use Ecto.Schema
  import Ecto.Changeset
  alias SpawnApi.Spawn.Generator

  schema "api_schemas" do
    field :schema, :map, default: %{}

    timestamps()
  end

  @doc false
  def changeset(api_schema, attrs) do
    api_schema
    |> cast(attrs, [:schema])
    |> validate_required([:schema])
  end

  def generate_data(api_schema, params \\ %{}) do
    Enum.reduce(api_schema.schema, %{}, fn {type, name}, acc ->
      data = Generator.generate(type, params)
      Map.put(acc, name, data)
    end)
  end
end
