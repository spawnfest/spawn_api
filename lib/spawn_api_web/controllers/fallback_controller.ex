defmodule SpawnApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use SpawnApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SpawnApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, status, %{message: message}}) do
    conn
    |> put_status(status)
    |> put_view(SpawnApiWeb.ApiSchemaView)
    |> render("error.json", %{message: message})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(SpawnApiWeb.ErrorView)
    |> render(:"404")
  end
end
