defmodule Elyxel.InviteTest do
  use Elyxel.ModelCase

  alias Elyxel.Invite

  @valid_attrs %{code: "some content", email: "some content", first_name: "some content", last_name: "some content", note: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Invite.changeset(%Invite{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Invite.changeset(%Invite{}, @invalid_attrs)
    refute changeset.valid?
  end
end
