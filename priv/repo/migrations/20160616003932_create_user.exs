defmodule Elyxel.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
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
