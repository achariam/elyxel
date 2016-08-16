defmodule Elyxel.Repo.Migrations.CreateInvite do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :first_name, :string, null: false, size: 100
      add :last_name, :string, null: false, size: 100
      add :email, :string, null: false, size: 250
      add :code, :string, null: false, size: 100
      add :note, :text

      timestamps()
    end
    create unique_index(:invites, [:email])
    create index(:invites, [:code])

  end
end
