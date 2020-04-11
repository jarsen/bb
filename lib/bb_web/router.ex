defmodule BBWeb.Router do
  use BBWeb, :router

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

  scope "/", BBWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
  end
end
