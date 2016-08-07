defmodule Elyxel.Router do
  use Elyxel.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.Authenticate
  end

  scope "/", Elyxel do
    pipe_through :browser

    get "/", PageController, :index
    get "/confirm", PageController, :confirm
    get "/askreset", PageController, :askreset
    post "/askreset", PageController, :askreset_password
    get "/reset", PageController, :reset
    post "/reset", PageController, :reset_password
    get "/login", PageController, :login, as: :login
    post "/login", PageController, :login_user, as: :login
    delete "/logout", PageController, :logout, as: :logout

    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create
  end

  scope "/users", Elyxel do
    pipe_through :browser

    resources "/", UserController, only: [:index, :show, :edit, :update]
  end

  scope "/admin", Elyxel do
    pipe_through :browser

    get "/", AdminController, :index
    resources "/users", AdminController, only: [:new, :create, :delete]
  end

  scope "/top", Elyxel do
    pipe_through :browser

    get "/", WireController, :index
  end

end
