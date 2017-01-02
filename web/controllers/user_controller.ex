defmodule Elyxel.UserController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  alias Elyxel.User

  plug :id_check when action in [:show]

  def action(conn, _), do: auth_action_role conn, ["admin", "user"], __MODULE__

  def show(conn, %{"id" => id}, _user) do
    user = User |> Repo.get!(id) |> Repo.preload([:wires])
    render(conn, "show.html", user: user)
  end
end