defmodule Elyxel.RegistrationController do
  use Elyxel.Web, :controller

  alias Elyxel.{User, Mailer, Invite}
  alias Openmaize.ConfirmEmail

  plug :scrub_params, "user" when action in [:create]
  plug :put_layout, "home.html"

  def signup(conn, params) do
    changeset = User.changeset(%User{}, params)
    render conn, "signup.html", changeset: changeset
  end

  def create(conn, %{"user" => %{"email" => email} = user_params}) do
    code = user_params["code"]
    changeset = User.changeset(%User{}, user_params)
    case Repo.one from i in Invite, where: i.code == ^code do
      nil ->
        conn
        |> put_flash(:error, "Invalid invite code.")
        |> render("signup.html", changeset: changeset)
      invite ->
        {key, link} = ConfirmEmail.gen_token_link(email)
        changeset = User.auth_changeset(%User{}, user_params, key)

        case Repo.insert(changeset) do
          {:ok, _user} ->
            Repo.delete invite
            Mailer.ask_confirm(email, link)
            conn
            |> put_flash(:info, "User created successfully.")
            |> redirect(to: page_path(conn, :index))
          {:error, changeset} ->
            render(conn, "signup.html", changeset: changeset)
        end
    end
  end

end