defmodule SpawnApi.Spawn do
  @moduledoc """
  The Spawn context.
  """

  import Ecto.Query, warn: false
  alias SpawnApi.Repo

  alias SpawnApi.Spawn.ApiSchema

  @doc """
  Returns the list of api_schemas.

  ## Examples

      iex> list_api_schemas()
      [%ApiSchema{}, ...]

  """
  def list_api_schemas do
    Repo.all(ApiSchema)
  end

  @doc """
  Gets a single api_schema.

  Raises `Ecto.NoResultsError` if the Api data does not exist.

  ## Examples

      iex> get_api_schema!(123)
      %ApiSchema{}

      iex> get_api_schema!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_schema!(id), do: Repo.get!(ApiSchema, id)

  @doc """
  Gets a single api_schema.

  Returns {:error, :unprocessable_entity, %{message: "ApiSchema not found for 123"}} or {:ok, api_schema}

  """
  def get_api_schema(id) do
    case Repo.get(ApiSchema, id) do
      nil -> {:error, :unprocessable_entity, %{message: "ApiSchema not found for #{inspect(id)}"}}
      api_schema -> {:ok, api_schema}
    end
  end

  @doc """
  Creates a api_schema.

  ## Examples

      iex> create_api_schema(%{field: value})
      {:ok, %ApiSchema{}}

      iex> create_api_schema(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_schema(attrs \\ %{}) do
    %ApiSchema{}
    |> ApiSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_schema.

  ## Examples

      iex> update_api_schema(api_schema, %{field: new_value})
      {:ok, %ApiSchema{}}

      iex> update_api_schema(api_schema, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_schema(%ApiSchema{} = api_schema, attrs) do
    api_schema
    |> ApiSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ApiSchema.

  ## Examples

      iex> delete_api_schema(api_schema)
      {:ok, %ApiSchema{}}

      iex> delete_api_schema(api_schema)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_schema(%ApiSchema{} = api_schema) do
    Repo.delete(api_schema)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_schema changes.

  ## Examples

      iex> change_api_schema(api_schema)
      %Ecto.Changeset{source: %ApiSchema{}}

  """
  def change_api_schema(%ApiSchema{} = api_schema) do
    ApiSchema.changeset(api_schema, %{})
  end
end
