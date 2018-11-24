defmodule SpawnApi.Repo do
  use Ecto.Repo,
    otp_app: :spawn_api,
    adapter: Ecto.Adapters.Postgres
end
