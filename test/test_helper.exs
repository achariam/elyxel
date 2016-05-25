ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Elyxel.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Elyxel.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Elyxel.Repo)

