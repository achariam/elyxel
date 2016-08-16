defmodule Elyxel.Invite do
  use Elyxel.Web, :model

  schema "invites" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :code, :string
    field :note, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :code, :note])
    |> validate_required([:first_name, :last_name, :email])
    |> validate_format(:email, ~r/@/, message: "Please enter a valid email address.")
    |> unique_constraint(:email, message: "Invite already sent to email.")
  end
end
