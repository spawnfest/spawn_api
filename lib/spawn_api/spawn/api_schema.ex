defmodule SpawnApi.Spawn.ApiSchema do
  @moduledoc """
    This module represents the schema the user requests as mock data.
    The schema is a JSON object where the values are types,
    and the keys are the names of the fields they request.
  """

  alias SpawnApi.Spawn.ApiSchema
  @type schema() :: %ApiSchema{}

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

  @spec generate(schema(), integer()) :: Map.t()
  def generate(%ApiSchema{} = api_schema, rows \\ 1000) do
    0..(rows - 1)
    |> Enum.map(fn i ->
      generate_data(api_schema, %{index: i})
    end)
    |> Enum.reduce(%{}, fn map, acc ->
      Enum.reduce(map, acc, fn {name, data}, acc ->
        cond do
          curr_data = Map.get(acc, name) ->
            Map.put(acc, name, curr_data ++ [data])

          true ->
            Map.put(acc, name, [data])
        end
      end)
    end)
  end

  @spec generate_data(schema(), Map.t()) :: Map.t()
  def generate_data(%ApiSchema{} = api_schema, params \\ %{}) do
    Enum.reduce(api_schema.schema, %{}, fn {name, type}, acc ->
      data = Generator.generate(type, params)
      Map.put(acc, name, data)
    end)
  end
end
