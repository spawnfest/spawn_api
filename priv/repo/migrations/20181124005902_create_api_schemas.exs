defmodule SpawnApi.Repo.Migrations.CreateApiSchemas do
  use Ecto.Migration

  def change do
    create table(:api_schemas) do
      add :schema, :map, default: %{}

      timestamps()
    end
  end
end
