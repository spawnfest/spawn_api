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

  @spec generate_data(schema(), Map.t(), integer) :: Map.t()
  def generate_data(api_schema, params \\ %{}, rows \\ 1000)
  def generate_data(_, _, rows) when rows <= 0, do: %{}

  def generate_data(%ApiSchema{} = api_schema, params, rows) do
    Enum.reduce(api_schema.schema, %{}, fn {name, type}, acc ->
      data = generate_rows(type, params, rows)
      Map.put(acc, name, data)
    end)
  end

  @spec generate_rows(String.t(), Map.t(), integer) :: List.t()
  def generate_rows(type, params, rows) do
    0..(rows - 1)
    |> Enum.map(fn i ->
      Generator.generate(type, Map.put(params, :index, i))
    end)
  end
end
