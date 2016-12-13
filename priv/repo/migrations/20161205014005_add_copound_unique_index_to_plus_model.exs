defmodule Elyxel.Repo.Migrations.AddCopoundUniqueIndexToPlusModel do
  use Ecto.Migration

  def change do
    create index(:pluses, [:user_id, :wire_id], unique: true)
  end
end
