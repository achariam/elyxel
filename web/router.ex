defmodule Elyxel.Router do
  use Elyxel.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.Authenticate, db_module: Elyxel.OpenmaizeEcto
    plug NavigationHistory.Tracker
  end

  scope "/", Elyxel do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/confirm", PageController, :confirm
    get "/askreset", PageController, :askreset
    post "/askreset", PageController, :askreset_password
    get "/reset", PageController, :reset
    post "/reset", PageController, :reset_password
    get "/login", PageController, :login, as: :login
    post "/login", PageController, :login_user, as: :login
    delete "/logout", PageController, :logout, as: :logout

    get "/signup", RegistrationController, :signup
    post "/signup", RegistrationController, :create

    get "/top", WireController, :top
    get "/recent", WireController, :recent
    get "/submit", WireController, :submit
    post "/submit", WireController, :create

  end

  scope "/wires", Elyxel do
    pipe_through :browser

    resources "/", WireController, only: [:show] do
      post "/plus", WireController, :plus
      delete "/zero", WireController, :zero
      post "/comment", WireController, :comment
    end
  end

  scope "/users", Elyxel do
    pipe_through :browser

    resources "/", UserController, only: [:show]
  end

  scope "/admin", Elyxel do
    pipe_through :browser

    get "/", AdminController, :index
    resources "/users", AdminController, only: [:new, :create, :delete]
    resources "/invites", InviteController, only: [:new, :create, :delete]
  end
end
