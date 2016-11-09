defmodule Elyxel.PlusTest do
  use Elyxel.ModelCase

  alias Elyxel.Plus

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Plus.changeset(%Plus{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Plus.changeset(%Plus{}, @invalid_attrs)
    refute changeset.valid?
  end
end
