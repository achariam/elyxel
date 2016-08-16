defmodule Elyxel.User do
  use Elyxel.Web, :model

  alias Elyxel.OpenmaizeEcto

  schema "users" do
    field :email, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :role, :string, default: "user"
    field :confirmed_at, Ecto.DateTime
    field :confirmation_token, :string
    field :confirmation_sent_at, Ecto.DateTime
    field :reset_token, :string
    field :reset_sent_at, Ecto.DateTime

    has_many :wires, Elyxel.Wire
    timestamps
  end

  @required_fields ~w(email username first_name last_name password_hash)
  @optional_fields ~w(confirmed_at confirmation_token confirmation_sent_at reset_token reset_sent_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_length(:username, min: 1, max: 100)
    |> unique_constraint(:username, message: "Username already taken.")
    |> validate_format(:email, ~r/@/, message: "Please enter a valid email address.")
    |> unique_constraint(:email, message: "Email already registered.")
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