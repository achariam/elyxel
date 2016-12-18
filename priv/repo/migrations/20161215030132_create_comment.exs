defmodule Elyxel.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :wire_id, references(:wires, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:user_id])
    create index(:comments, [:wire_id])

  end
end
