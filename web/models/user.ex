defmodule Elyxel.User do
  use Elyxel.Web, :model

  alias Elyxel.OpenmaizeEcto

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

    has_many :wires, Elyxel.Wire
    timestamps
  end

  @required_fields ~w(email username first_name last_name password_hash role confirmed_at confirmation_token confirmation_sent_at reset_token reset_sent_at)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(email role), ~w(username))
    |> validate_length(:username, min: 1, max: 100)
    |> unique_constraint(:email)
  end

  def auth_changeset(model, params, key) do
    model
    |> changeset(params)
    |> OpenmaizeEcto.add_password_hash(params)
    |> OpenmaizeEcto.add_confirm_token(key)
  end

  def reset_changeset(model, params, key) do
    model
    |> cast(params, ~w(email), [])
    |> OpenmaizeEcto.add_reset_token(key)
  end
end