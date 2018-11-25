defmodule SpawnApi.Spawn.Generator do
  def generate(type, params \\ %{})
  def generate("first_name", _), do: Faker.Name.first_name()
  def generate("name", _), do: Faker.Name.name()
  def generate("last_name", _), do: Faker.Name.last_name()
  def generate("email", _), do: Faker.Internet.email()
  def generate("ip_v4_address", _), do: Faker.Internet.ip_v4_address()
  def generate("ip_v6_address", _), do: Faker.Internet.ip_v6_address()
  def generate("city", _), do: Faker.Address.city()
  def generate("country", _), do: Faker.Address.country()
  def generate("latitude", _), do: Faker.Address.latitude()
  def generate("longitude", _), do: Faker.Address.longitude()
  def generate("time_zone", _), do: Faker.Address.time_zone()
  def generate("zip_code", _), do: Faker.Address.zip_code()
  def generate("country_code", _), do: Faker.Address.country_code()
  def generate("uuid", _), do: Faker.UUID.v4()

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
