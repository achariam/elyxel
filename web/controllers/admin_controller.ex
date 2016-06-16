defmodule Elyxel.AdminController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  alias Openmaize.ConfirmEmail
  alias Elyxel.{Mailer, User}

  plug :scrub_params, "user" when action in [:create]

  def action(conn, _), do: authorize_action conn, ["admin"], __MODULE__

  def index(conn, _params, _user) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params, _user) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => %{"email" => email} = user_params}, _user) do
    {key, link} = ConfirmEmail.gen_token_link(email)
    changeset = User.auth_changeset(%User{}, user_params, key)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        Mailer.ask_confirm(email, link)
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: admin_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_path(conn, :index))
  end
end