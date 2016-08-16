defmodule Elyxel.InviteController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  import Ecto.Changeset
  alias Elyxel.{Mailer, User, Invite}

  plug :scrub_params, "invite" when action in [:create]

  def action(conn, _), do: auth_action_role conn, ["admin"], __MODULE__

  def new(conn, _params, _user) do
    changeset = Invite.changeset(%Invite{})
    render conn, "invite_form.html", changeset: changeset
  end

  def create(conn, %{"invite" => %{"email" => email, "first_name" => first_name, "last_name" => last_name} = invite_params}, _) do
    changeset = Invite.changeset(%Invite{}, invite_params)

    case Repo.one from u in User, where: u.email == ^email do
      nil ->
        {code, link} = gen_invite_code(email, first_name, last_name)
        changeset = put_change(changeset, :code, code)

        case Repo.insert(changeset) do
          {:ok, _invite} ->
            Mailer.invite(email, link)
            conn
            |> put_flash(:info, "Invitation sent.")
            |> render("invite_form.html", changeset: changeset)
          {:error, changeset} ->
            {conn, changeset} = case Repo.one from i in Invite, where: i.email == ^email do
              nil -> {conn, changeset}
              _invite ->
                conn
                |> put_flash(:info, "Invitation already sent to this email.")
                |> render("invite_form.html", changeset: changeset)
            end
            render(conn, "invite_form.html", changeset: changeset)

        end
      _->
        conn
        |> put_flash(:info, "User already has account.")
        |> render("invite_form.html", changeset: changeset)
    end
  end

  defp gen_invite_code(email, first_name, last_name) do
    code = :crypto.strong_rand_bytes(24) |> Base.url_encode64
    {code, "first_name=#{URI.encode_www_form(first_name)}&last_name=#{URI.encode_www_form(last_name)}&email=#{URI.encode_www_form(email)}&code=#{code}"}
  end
end