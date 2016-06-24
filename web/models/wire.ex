defmodule Elyxel.Wire do
  use Elyxel.Web, :model

  schema "wires" do
    field :title, :string
    field :link, :string
    field :context, :string
    field :pluses, :integer
    field :minuses, :integer
    belongs_to :user, Elyxel.User, foreign_key: :user_id

    timestamps
  end

  @required_fields ~w(title link context user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
