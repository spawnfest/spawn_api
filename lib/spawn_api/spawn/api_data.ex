defmodule SpawnApi.Spawn.ApiData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_datas" do
    field :data, :map

    timestamps()
  end

  @doc false
  def changeset(api_data, attrs) do
    api_data
    |> cast(attrs, [:data])
    |> validate_required([:data])
  end
end
