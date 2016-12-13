defmodule Elyxel.Repo.Migrations.CreatePlus do
  use Ecto.Migration

  def change do
    create table(:pluses) do
    	add :user_id, references(:users, on_delete: :nothing)
    	add :wire_id, references(:wires, on_delete: :nothing)

      timestamps()
    end
    create index(:pluses, [:user_id])
    create index(:pluses, [:wire_id])

  end
end
