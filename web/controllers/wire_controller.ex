defmodule Elyxel.WireController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  import Elyxel.Pagination
  import Ecto.Query
  alias Elyxel.Wire

	def action(conn, _), do: auth_action_role conn, ["admin", "user"], __MODULE__

	def top(conn, %{"p" => page}, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :pluses)
	  	|> preload([:user])
	  	|> page(page: page, per_page: 5)
	  render(conn, "top.html", wires: wires)
	end

	def top(conn, _params, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :pluses)
	  	|> preload([:user])
	  	|> page(page: 0, per_page: 5)
	  render(conn, "top.html", wires: wires)
	end

	def recent(conn, %{"p" => page}, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :inserted_at)
	  	|> preload([:user])
	  	|> page(page: page, per_page: 5)
	  render(conn, "recent.html", wires: wires)
	end

	def recent(conn, _params, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :inserted_at)
	  	|> preload([:user])
	  	|> page(page: 0, per_page: 5)
	  render(conn, "recent.html", wires: wires)
	end
end