defmodule Elyxel.UserView do
  use Elyxel.Web, :view

  def user_name(%{email: email}) do
    email |> String.split("@") |> hd |> String.capitalize
  end
  def user_name(%{username: username}) do
    username |> String.capitalize
  end
  def user_name(_), do: "The Black Knight"
end