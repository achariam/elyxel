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

	def submit(conn, _params, _user) do
		changeset = Wire.changeset(%Wire{})
		render conn, "submit.html", changeset: changeset
	end

	def create(conn, %{"wire" => wire}, user) do
		changeset = user
			|> build_assoc(:wires)
			|> Wire.changeset(wire)

		case Repo.insert(changeset) do
		  {:ok, _user} ->
		    conn
		    |> put_flash(:info, "Wire created successfully.")
		    |> redirect(to: wire_path(conn, :recent))
		  {:error, changeset} ->
		    render(conn, "submit.html", changeset: changeset)
		end
	end
end