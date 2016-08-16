defmodule Elyxel.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false, size: 250
      add :username, :string, null: false, size: 100
      add :first_name, :string, null: false, size: 100
      add :last_name, :string, null: false, size: 100
      add :password_hash, :string, null: false
      add :role, :string, null: false
      add :confirmed_at, :datetime
      add :confirmation_token, :string
      add :confirmation_sent_at, :datetime
      add :reset_token, :string
      add :reset_sent_at, :datetime

      timestamps
    end
    create unique_index(:users, [:email])
    create unique_index(:users, [:username])

  end
end
