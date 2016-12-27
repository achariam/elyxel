defmodule Elyxel.Lightning do
  @moduledoc """
  Plus Helper
  """
  import Ecto.Query
  alias Elyxel.Plus
  alias Elyxel.Repo


  def lightning_state(user, wire) do
    query = Plus
    |> limit(1)
    |> where(user_id: ^user)
    |> where(wire_id: ^wire)
    |> Repo.all

    case length(query) do
      1 -> true
      0 -> false
    end
  end
end