defmodule SpawnApi.Spawn do
  @moduledoc """
  The Spawn context.
  """

  import Ecto.Query, warn: false
  alias SpawnApi.Repo

  alias SpawnApi.Spawn.ApiData

  @doc """
  Returns the list of api_datas.

  ## Examples

      iex> list_api_datas()
      [%ApiData{}, ...]

  """
  def list_api_datas do
    Repo.all(ApiData)
  end

  @doc """
  Gets a single api_data.

  Raises `Ecto.NoResultsError` if the Api data does not exist.

  ## Examples

      iex> get_api_data!(123)
      %ApiData{}

      iex> get_api_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_data!(id), do: Repo.get!(ApiData, id)

  @doc """
  Creates a api_data.

  ## Examples

      iex> create_api_data(%{field: value})
      {:ok, %ApiData{}}

      iex> create_api_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_data(attrs \\ %{}) do
    %ApiData{}
    |> ApiData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_data.

  ## Examples

      iex> update_api_data(api_data, %{field: new_value})
      {:ok, %ApiData{}}

      iex> update_api_data(api_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_data(%ApiData{} = api_data, attrs) do
    api_data
    |> ApiData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ApiData.

  ## Examples

      iex> delete_api_data(api_data)
      {:ok, %ApiData{}}

      iex> delete_api_data(api_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_data(%ApiData{} = api_data) do
    Repo.delete(api_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_data changes.

  ## Examples

      iex> change_api_data(api_data)
      %Ecto.Changeset{source: %ApiData{}}

  """
  def change_api_data(%ApiData{} = api_data) do
    ApiData.changeset(api_data, %{})
  end
end
