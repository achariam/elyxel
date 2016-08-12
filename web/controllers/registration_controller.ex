defmodule Elyxel.RegistrationController do
  use Elyxel.Web, :controller

  alias Elyxel.{User, Repo, Mailer}
  alias Openmaize.ConfirmEmail

  plug :scrub_params, "user" when action in [:create]
  plug :put_layout, "home.html"

  def signup(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "signup.html", changeset: changeset
  end

  def create(conn, %{"user" => %{"email" => email} = user_params}) do
    {key, link} = ConfirmEmail.gen_token_link(email)
    changeset = User.auth_changeset(%User{}, user_params, key)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        Mailer.ask_confirm(email, link)
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "signup.html", changeset: changeset)
    end
  end

end