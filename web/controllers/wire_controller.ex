defmodule Elyxel.WireController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  alias Elyxel.{User, Wire}

	def action(conn, _), do: auth_action_role conn, ["admin", "user"], __MODULE__

	def index(conn, _params, _user) do
	  wires = Wire |> Repo.all |> Repo.preload([:user])
	  render(conn, "index.html", wires: wires)
	end
end