defmodule Elyxel.PageController do
  use Elyxel.Web, :controller

  import Elyxel.{Authorize, Confirm}
  alias Openmaize.Login.Name
  alias Elyxel.{Mailer, User}

  plug Openmaize.ConfirmEmail, [key_expires_after: 30,
    mail_function: &Mailer.receipt_confirm/1] when action in [:confirm]
  plug Openmaize.ResetPassword, [key_expires_after: 30,
    mail_function: &Mailer.receipt_confirm/1] when action in [:reset_password]

  #plug Openmaize.Login, [unique_id: :email] when action in [:login_user]
  plug Openmaize.Login, [unique_id: &Name.email_username/1] when action in [:login_user]
  plug Openmaize.OnetimePass when action in [:login_twofa]
  plug Openmaize.Logout when action in [:logout]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def login_user(conn, params) do
    handle_login conn, params
  end

  def login_twofa(conn, params) do
    handle_login conn, params
  end

  def logout(conn, params) do
    handle_logout conn, params
  end

  def confirm(conn, params) do
    handle_confirm conn, params
  end

  def askreset(conn, _params) do
    render conn, "askreset_form.html"
  end

  def askreset_password(conn, %{"user" => %{"email" => email} = user_params}) do
    {key, link} = Openmaize.ConfirmEmail.gen_token_link(email)
    changeset = User.reset_changeset(Repo.get_by(User, email: email), user_params, key)

    case Repo.update(changeset) do
      {:ok, _user} ->
        Mailer.ask_reset(email, link)
        conn
        |> put_flash(:info, "Check your inbox for instructions on how to reset your password.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "askreset_form.html", changeset: changeset)
    end
  end

  def reset(conn, %{"email" => email, "key" => key}) do
    render conn, "reset_form.html", email: email, key: key
  end

  def reset_password(conn, params) do
    handle_reset conn, params
  end
end
