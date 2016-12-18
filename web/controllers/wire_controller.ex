defmodule Elyxel.WireController do
  use Elyxel.Web, :controller

  import Elyxel.Authorize
  import Elyxel.Pagination
  import Ecto.Query
  alias Elyxel.Wire
  alias Elyxel.Plus
  alias Elyxel.Repo
  alias Elyxel.Comment

  plug :scrub_params, "wire" when action in [:create]
  plug :scrub_params, "comment" when action in [:comment]

	def action(conn, _), do: auth_action_role conn, ["admin", "user"], __MODULE__

	def top(conn, %{"p" => page}, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :rating)
	  	|> preload([:user, :pluses, :comments])
	  	|> page(page: page, per_page: 10)
	  render(conn, "top.html", wires: wires)
	end

	def top(conn, _params, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :rating)
	  	|> preload([:user, :pluses, :comments])
	  	|> page(page: 0, per_page: 10)
	  render(conn, "top.html", wires: wires)
	end

	def recent(conn, %{"p" => page}, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :inserted_at)
	  	|> preload([:user, :pluses, :comments])
	  	|> page(page: page, per_page: 10)
	  render(conn, "recent.html", wires: wires)
	end

	def recent(conn, _params, _user) do
	  wires =
	  	Wire
	  	|> order_by(desc: :inserted_at)
	  	|> preload([:user, :pluses, :comments])
	  	|> page(page: 0, per_page: 10)
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
			|> Ecto.Changeset.put_change(:rating, 0)

		case Repo.insert(changeset) do
		  {:ok, _user} ->
		    conn
		    |> put_flash(:info, "Wire created successfully.")
		    |> redirect(to: wire_path(conn, :recent))
		  {:error, changeset} ->
		    render(conn, "submit.html", changeset: changeset)
		end
	end

	def show(conn, %{"id" => id}, _user) do
	  wire = Wire |> Repo.get!(id) |> Repo.preload([:user, :pluses, :comments])
	  changeset = Comment.changeset(%Comment{})
	  render(conn, "detail.html", wire: wire, changeset: changeset)
	end

	def comment(conn, %{"comment" => %{"content" => content}, "wire_id" => wire_id}, user) do
		wire = Wire |> Repo.get!(wire_id) |> Repo.preload([:user, :pluses, :comments])

		changeset = Comment.changeset(%Comment{}, %{"content" => content, "user_id" => user.id, "wire_id" => wire_id})

		case Repo.insert(changeset) do
		  {:ok, _user} ->
		  	conn
		  	|> put_flash(:info, "Comment added.")
		  	|> redirect(to: NavigationHistory.last_path(conn, default: "/"))
		  {:error, changeset} ->
		    render(conn, "detail.html", wire: wire, changeset: changeset)
		end
	end

	def plus(conn, %{"wire_id" => wire_id}, user) do
		wire = Wire |> Repo.get!(wire_id)
		user_assoc = build_assoc(user, :pluses, %Plus{})
		changeset = build_assoc(wire, :pluses, user_assoc)

		case Repo.insert(changeset) do
			{:ok, _user} ->
				conn
				|> redirect(to: NavigationHistory.last_path(conn, default: "/"))
			{:error, changeset} ->
				conn
				|> redirect(to: NavigationHistory.last_path(conn, default: "/"))
		end
	end

	def zero(conn, %{"wire_id" => wire_id}, user) do
    plus = Repo.get_by(Plus, wire_id: wire_id, user_id: user.id)
    Repo.delete(plus)

	  conn
	  |> put_flash(:info, "Wire zeroed out.")
	  |> redirect(to: NavigationHistory.last_path(conn, default: "/"))
	end
end