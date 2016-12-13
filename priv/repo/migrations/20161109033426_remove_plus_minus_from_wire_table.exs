defmodule Elyxel.Repo.Migrations.RemovePlusMinusFromWireTable do
  use Ecto.Migration

  def change do
    alter table(:wires) do
      remove :pluses
      remove :minuses
    end
  end
end
