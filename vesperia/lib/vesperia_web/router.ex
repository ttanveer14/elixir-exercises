defmodule VesperiaWeb.Router do
  use VesperiaWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", VesperiaWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/hello", HelloController, :world)
    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", VesperiaWeb do
  #   pipe_through :api
  # end
end
