defmodule Elyxel.ConfirmTest do
  use Elyxel.ConnCase

  @valid_link "email=gladys%40mail.com&key=pu9-VNdgE8V9qZo19rlcg3KUNjpxuixg"
  @invalid_link "email=gladys%40mail.com&key=pu9-VNdgE8V9QzO19RLCG3KUNjpxuixg"
  @valid_attrs %{email: "gladys@mail.com", password: "^hEsdg*F899",
    key: "pu9-VNdgE8V9qZo19rlcg3KUNjpxuixg"}
  @invalid_attrs %{email: "gladys@mail.com",  password: "^hEsdg*F899",
    key: "pu9-VNDGe8v9QzO19RLCg3KUNjpxuixg"}
  @invalid_pass %{email: "gladys@mail.com", password: "qwerty",
    key: "pu9-VNdgE8V9qZo19rlcg3KUNjpxuixg"}

  # The first two tests are for email confirmation.
  # In this case, you need to add the confirmation_token (key)
  # to a user with the email "gladys@mail.com" before running these tests
  test "confirmation succeeds for correct key" do
    conn = conn() |> get("/confirm?" <> @valid_link)
    assert conn.private.phoenix_flash["info"] =~ "successfully confirmed"
    assert redirected_to(conn) == "/login"
  end

  test "confirmation fails for incorrect key" do
    conn = conn() |> get("/confirm?" <> @invalid_link)
    assert conn.private.phoenix_flash["error"] =~ "failed"
    assert redirected_to(conn) == "/login"
  end

  # The next three tests are for resetting passwords.
  # You need to add the reset_token (key) to a user
  # with the email "gladys@mail.com" before running these tests
  test "reset password succeeds for correct key" do
    conn = conn() |> post("/reset", user: @valid_attrs)
    assert conn.private.phoenix_flash["info"] =~ "successfully confirmed"
    assert redirected_to(conn) == "/login"
  end

  test "reset password fails for incorrect key" do
    conn = conn() |> post("/reset", user: @invalid_attrs)
    assert conn.private.phoenix_flash["error"] =~ "failed"
  end

  test "reset password fails for invalid password" do
    conn = conn() |> post("/reset", user: @invalid_pass)
    assert conn.private.phoenix_flash["error"] =~ "password should be"
  end

end
