defmodule SpawnApi.Spawn.ApiSchema do
  use Ecto.Schema
  import Ecto.Changeset

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
end
