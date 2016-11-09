defmodule Elyxel.Plus do
  use Elyxel.Web, :model

  schema "pluses" do
    belongs_to :user, Elyxel.User, foreign_key: :user_id
    belongs_to :wire, Elyxel.Wire, foreign_key: :wire_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
