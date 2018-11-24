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

  scope "/", SpawnApiWeb do
    pipe_through :browser

    # get "/api_data/:id", ApiDataController, :show
    get "/api_data/new", ApiDataController, :new
    get "/*path", ApiDataController, :new
  end

  scope "/api", SpawnApiWeb do
    pipe_through :api

    resources "/api_schemas", ApiSchemaController, except: [:new, :edit]
  end
end
