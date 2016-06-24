defmodule Elyxel.Repo.Migrations.CreateWire do
  use Ecto.Migration

  def change do
    create table(:wires) do
      add :title, :string, size: 250
      add :link, :string, size: 250
      add :context, :string, size: 250
      add :pluses, :integer
      add :minuses, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:wires, [:user_id])

  end
end
