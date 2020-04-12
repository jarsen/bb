defmodule BBWeb.Router do
  use BBWeb, :router
  import BBWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :authenticate_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BBWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/login", UserSessionController, :new
    post "/users/login", UserSessionController, :create
  end

  scope "/", BBWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", PageController, :index
    delete "/users/logout", UserSessionController, :delete
  end
end
