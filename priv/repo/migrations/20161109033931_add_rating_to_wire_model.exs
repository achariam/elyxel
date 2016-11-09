defmodule Elyxel.Repo.Migrations.AddRatingToWireModel do
  use Ecto.Migration

  def change do
    alter table(:wires) do
    	add :rating, :integer
    end
  end
end
