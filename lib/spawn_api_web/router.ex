defmodule SpawnApiWeb.Router do
  use SpawnApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SpawnApiWeb do
    pipe_through :api

    resources "/api_schemas", ApiSchemaController, except: [:new, :edit]
    get "/api_schemas/export_csv/:id", ApiSchemaController, :export_csv
    get "/api_schemas/generate/:id", ApiSchemaController, :generate
  end

  scope "/", SpawnApiWeb do
    pipe_through :browser

    get "/api_schemas/new", ApiSchemaController, :new
    get "/*path", ApiSchemaController, :new
  end
end
