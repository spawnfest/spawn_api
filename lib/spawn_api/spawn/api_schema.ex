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

  def generate(api_schema, rows \\ 1000) do
    0..(rows - 1)
    |> Enum.map(fn i ->
      generate_data(api_schema, %{index: i})
    end)
    |> Enum.reduce(%{}, fn map, acc ->
      Enum.reduce(map, acc, fn {name, data}, acc ->
        cond do
          Map.get(acc, name) ->
            curr_data = Map.get(acc, name)
            Map.put(acc, name, curr_data ++ [data])

          true ->
            Map.put(acc, name, [data])
        end
      end)
    end)
  end

  def generate_data(api_schema, params \\ %{}) do
    Enum.reduce(api_schema.schema, %{}, fn {type, name}, acc ->
      data = Generator.generate(type, params)
      Map.put(acc, name, data)
    end)
  end
end
