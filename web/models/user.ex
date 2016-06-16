defmodule Elyxel.User do
  use Elyxel.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :role, :string
    field :confirmed_at, Ecto.DateTime
    field :confirmation_token, :string
    field :confirmation_sent_at, Ecto.DateTime
    field :reset_token, :string
    field :reset_sent_at, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(email username first_name last_name password_hash role confirmed_at confirmation_token confirmation_sent_at reset_token reset_sent_at)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
