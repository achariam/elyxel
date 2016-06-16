defmodule Elyxel.UserTest do
  use Elyxel.ModelCase

  alias Elyxel.User

  @valid_attrs %{confirmation_sent_at: "2010-04-17 14:00:00", confirmation_token: "some content", confirmed_at: "2010-04-17 14:00:00", email: "some content", first_name: "some content", last_name: "some content", password_hash: "some content", reset_sent_at: "2010-04-17 14:00:00", reset_token: "some content", role: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
