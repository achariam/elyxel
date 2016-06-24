defmodule Elyxel.WireTest do
  use Elyxel.ModelCase

  alias Elyxel.Wire

  @valid_attrs %{context: "some content", link: "some content", minuses: 42, pluses: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wire.changeset(%Wire{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wire.changeset(%Wire{}, @invalid_attrs)
    refute changeset.valid?
  end
end
