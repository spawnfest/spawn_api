defmodule SpawnApi.Spawn.Generator do
  def generate(type, params \\ %{})
  def generate("first_name", _), do: Faker.Name.first_name()
  def generate("name", _), do: Faker.Name.name()
  def generate("last_name", _), do: Faker.Name.last_name()
  def generate("email", _), do: Faker.Internet.email()
  def generate("ip_v4_address", _), do: Faker.Internet.ip_v4_address()
  def generate("ip_v6_address", _), do: Faker.Internet.ip_v6_address()

  def generate("integer", params) do
    Enum.random(Map.get(params, :range, 0..1000))
  end

  def generate("float", params) do
    :rand.uniform() * Map.get(params, :end, 1000) + Map.get(params, :start, 0)
  end

  def generate("id", params) do
    Map.get(params, :index)
  end

  # Fallback case where type provided does not match any of the above.
  def generate(_, _), do: nil
end
