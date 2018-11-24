defmodule SpawnApi.Spawn.ApiSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_schemas" do
    field :data, :map

    timestamps()
  end

  @doc false
  def changeset(api_schema, attrs) do
    api_schema
    |> cast(attrs, [:data])
    |> validate_required([:data])
  end
end
