defmodule Elyxel.Confirm do

  import Phoenix.Controller
  import Elyxel.Authorize

  @doc """
  Check the user's confirmation key.

  ## Examples

  Add the following line to the controller file:

      plug Openmaize.ConfirmEmail, [db_module: Welcome.OpenmaizeEcto,
        mail_function: &Mailer.receipt_confirm/1] when action in [:confirm]

  and then call `handle_confirm` from the `confirm` function in the controller.

  See the documentation for Openmaize.ConfirmEmail for more information.
  """
  def handle_confirm(%Plug.Conn{private: %{openmaize_error: message}} = conn, _params) do
    unauthenticated conn, message
  end
  def handle_confirm(%Plug.Conn{private: %{openmaize_info: message}} = conn, _params) do
    conn |> put_flash(:info, message) |> redirect(to: "/login")
  end

  @doc """
  Check the user's reset password key.

  If the check is successful, the user's password will be reset, and the
  user will be redirected to the login page. If there is an error, the
  reset password form will be rerendered with the email and key.

  ## Examples

  Add the following line to the controller file:

      plug Openmaize.ResetPassword, [db_module: Welcome.OpenmaizeEcto,
        mail_function: &Mailer.receipt_confirm/1] when action in [:reset_password]

  and then call `handle_reset` from the `reset_password` function in the controller.

  See the documentation for Openmaize.ResetPassword for more information.
  """
  def handle_reset(%Plug.Conn{private: %{openmaize_error: message}} = conn,
                  %{"user" => %{"email" => email, "key" => key}}) do
    conn
    |> put_flash(:error, message)
    |> render("reset_form.html", email: email, key: key)
  end
  def handle_reset(%Plug.Conn{private: %{openmaize_info: message}} = conn, _params) do
    conn |> put_flash(:info, message) |> redirect(to: "/login")
  end
end
