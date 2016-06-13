# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elyxel.Repo.insert!(%Elyxel.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# In this example, there are several values for each user.
# The required values are `username`, `password_hash` and `role`.

users = [
  %{
    email: "matt@mail.com",
    username: "matt",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin",
    otp_required: true,
    otp_secret: Comeonin.Otp.gen_secret,
    confirmed_at: Ecto.DateTime.utc,
  },
  %{
    email: "alpha@mail.com",
    username: "alpha",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
  },
  %{
    email: "beta@mail.com",
    username: "beta",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
  }
]

for user <- users do
  Map.merge(%Elyxel.User{}, user) |> Elyxel.Repo.insert!
end