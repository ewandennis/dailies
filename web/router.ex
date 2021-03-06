defmodule Dailies.Router do
  use Dailies.Web, :router

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

  scope "/", Dailies do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/editor", Dailies do
    pipe_through :browser

    resources "/", EditorController
  end

  scope "/api", Dailies do
    pipe_through :api
    resources "/slides", SlideController
  end

  scope "/webhook", Dailies do
    pipe_through :api
    post "/", RelayWebhookController, :post
  end
end
