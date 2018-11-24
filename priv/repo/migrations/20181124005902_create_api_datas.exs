defmodule SpawnApi.Repo.Migrations.CreateApiDatas do
  use Ecto.Migration

  def change do
    create table(:api_datas) do
      add :data, :map

      timestamps()
    end
  end
end
