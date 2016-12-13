defmodule Elyxel.UserController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  alias Elyxel.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :id_check when action in [:show, :edit, :update]

  def action(conn, _), do: auth_action_role conn, ["admin", "user"], __MODULE__

  def index(conn, _params, _user) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}, _user) do
    user = User |> Repo.get!(id) |> Repo.preload([:wires])
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end