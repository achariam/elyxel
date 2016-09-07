defmodule Elyxel.WireController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  import Elyxel.Pagination
  import Ecto.Query
  alias Elyxel.Wire

	def action(conn, _), do: auth_action_role conn, ["admin", "user"], __MODULE__

	def index(conn, %{"p" => page}, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :inserted_at)
	  	|> preload([:user])
	  	|> page(page: page, per_page: 5)
	  render(conn, "index.html", wires: wires)
	end

	def index(conn, _params, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :inserted_at)
	  	|> preload([:user])
	  	|> page(page: 0, per_page: 5)
	  render(conn, "index.html", wires: wires)
	end
end