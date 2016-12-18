defmodule Elyxel.Comment do
  use Elyxel.Web, :model

  schema "comments" do
    field :content, :string
    belongs_to :user, Elyxel.User, foreign_key: :user_id
    belongs_to :wire, Elyxel.Wire, foreign_key: :wire_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :user_id, :wire_id])
    |> validate_required([:content, :user_id, :wire_id])
    |> validate_length(:content, min: 1, max: 1000)
    |> strip_unsafe_content(params)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:wire_id)
  end

  defp strip_unsafe_content(model, %{"content" => nil}) do
    model
  end

  defp strip_unsafe_content(model, %{"content" => content}) do
    {:safe, clean_content} = Phoenix.HTML.html_escape(content)
    model |> put_change(:content, clean_content)
  end

  defp strip_unsafe_content(model, _) do
    model
  end
end